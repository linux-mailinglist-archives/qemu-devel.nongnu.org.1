Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAC75C3BA
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmo9-00013q-NH; Fri, 21 Jul 2023 05:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmo3-00012w-Hm
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:52:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMmo1-0007gw-UN
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:52:15 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-521dd3d93bbso1970358a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689933132; x=1690537932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OariUAiKLVy0UUCuomeEEFFlFh5Ez/oIy3/WwbxvAiM=;
 b=mBQUnOEuMiy+L0m6CNzpvyycfKBD/07hfDF8sAgrdBv3RS7NHCYKOyv1dHMPQYqH24
 vQojG9ahA1rzVidL3O1lN4arT8iVrdW602D42t3cLogdV1UdexeHYnIRXMSDNyCFduo4
 WQK3IIExIJgOs3CCrIAkQxc3OnaLkUe+l3ubA+Ckh550vg8KEpGlwU6bvq7/pZ6qYg27
 1MInR5Qub3t+juf4FoRnB96NNXtnUyA+ccAv7HbZHdmugF+dJV0bEq+y61GHzdfLX3S0
 OYeVKWeZm3MoPmoCJW6NSNxmmDqFxY3Qzt0IAgcZqXUyRbRIo45RsDBC3OAeABoH/yHJ
 sucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689933132; x=1690537932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OariUAiKLVy0UUCuomeEEFFlFh5Ez/oIy3/WwbxvAiM=;
 b=ZelHn8TFeG556ktXL+EgT2ckjEyUvQwNVy5ZxDo+RC58GtN2H9vMdYHxkKc50MCFMY
 lVNN9REvtr/A9NLrkrstDhwJYAPr06hKpsr/R8j0EiQk2uDZ7BAAna6WD/8HBL4ECFqw
 HzVhLyAIBdU+CKvOS18HuLImChjVHQeWIpCNQKHQ/PoVCkP3tBk1+l7WblUDaH1B67tu
 HYwYwJRPe52hZfKNUm5/GrS1JX4YDkAEJHNhvJsjAKIqkDJrla5I7RkIm8EytO8TxJ3q
 vBKuCn3u0cJJFLoUuLuEilIb+buLGHxsiAukYmihmlvsG6921pogW9esyQpuMnYW0F0a
 IHfQ==
X-Gm-Message-State: ABy/qLaMgUZIAxBSZrRIui/H7VPiuwCAwif+9ClIUCTqLgNHPgByd3qd
 ty4KOaLLrDLaMDaj+Wfbpl/l+TKVnf6HefXYmh4dEWXEYakaJw9Q
X-Google-Smtp-Source: APBJJlHPvQiYdZxFxA+xrftWZnZ9JTzdlfvFNu2iOWdOabjw5MMTWSBs6K1dHlqOhdcZWK9BNOXowEJUuVvOcs2IRhM=
X-Received: by 2002:a05:6402:60c:b0:51e:1bf3:f4ac with SMTP id
 n12-20020a056402060c00b0051e1bf3f4acmr1203866edv.27.1689933132717; Fri, 21
 Jul 2023 02:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230719202736.2675295-16-eblake@redhat.com>
In-Reply-To: <20230719202736.2675295-16-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 10:52:01 +0100
Message-ID: <CAFEAcA9g1Yw32gZbRPYiXRnNgkxTVaXSAYoR7VSzj3znba8pAQ@mail.gmail.com>
Subject: Re: [PULL 00/14] NBD patches for 2023-07-19
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 19 Jul 2023 at 21:39, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 2c27fdc7a626408ee2cf30d791aa0b63027c7404:
>
>   Update version for v8.1.0-rc0 release (2023-07-19 20:31:43 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2023-07-19
>
> for you to fetch changes up to bfe04d0a7d5e8a4f4c9014ee7622af2056685974:
>
>   nbd: Use enum for various negotiation modes (2023-07-19 15:26:13 -0500)
>
> ----------------------------------------------------------------
> NBD patches through 2023-07-19
>
> - Denis V. Lunev: fix hang with 'ssh ... "qemu-nbd -c"'
> - Eric Blake: preliminary work towards NBD 64-bit extensions
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

