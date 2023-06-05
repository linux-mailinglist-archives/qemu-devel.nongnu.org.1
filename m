Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89272240C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:59:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67vK-0004gR-75; Mon, 05 Jun 2023 06:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q67vG-0004gF-TG
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:58:51 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q67vF-00016m-63
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:58:50 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51480d3e161so6850092a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685962726; x=1688554726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/FPxmomzFqd0RaRR0TWnXtHOsf7vpQzypQ/RcdiFKM=;
 b=Dn8hwRmkQD4nzeEgzI9Y9ZTIuiucNPMlDB3QhDvs1O/8BZf1YPV+p1brAwroxfgeTR
 m4e9Ry2wbehiEzdAn4iGPsbDw2ExIbIbF/7/TNLUaCrV2kC0wJCV6rpDt7gKUMAR8Ixs
 MezyV6nPXNerj/JNN96RLmZHWXNtnD7w0XXIAnyrXw+2wKqMOrvKKskTbP9jmIX8hVuW
 GBw/1xKrxbYfrX+czMenw3QouHxDKycmuZrngp1MiSNDU+mLoX6HCjTL3eDOggnj0RWI
 AizURqHxFWd9RM+fYQBfnsi66hZR7BGJOTNv9ZXPQk4vN8OGm6i9zazmPG5D4X/PuWN0
 hcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685962726; x=1688554726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/FPxmomzFqd0RaRR0TWnXtHOsf7vpQzypQ/RcdiFKM=;
 b=P/7x3rMeJpcKc7fpr6l2DGENWYSGBcP+HNI3IqQlIWPQD8F3zWB3tkjotIrW1Wfxlm
 gwOk0WxddP8gRjGqUMUL6aA1kCut6ju4DS9NBWJlu6EPTQfIJ+AJD6wlaHayAohLWs39
 odTL0/bcKSUroJOCvigovhonj6xEaJoHjmQxNnqg2AzG5r1PVn79dELethDrpHpu65gw
 nV5X86Lq0pxaljCnz/7tEIcWuTqz1nereZQ+AV7hMXRZrbbMWh5zrc+bQRadQGLGegV4
 FOjvM5DLH+kk+p75gjq98C9BZwdw6EVch1A8lNbs8UOX/8kuRrQ8TgT1l5mjPbeXRtCa
 GGQA==
X-Gm-Message-State: AC+VfDyOzAiM0mixFQ8HZnD210Dy5htfT/GhJKjwDt21snCWG+V9ce34
 ysU5dyCS2AanPtJLTJG/lf9081CXUeWR7ztDKs0XgQ==
X-Google-Smtp-Source: ACHHUZ6wa0HO76J3EqAJZse13xltqE37odtH0ug66yCEKaAvxyvY2GnQQhi1m+4qlc/k3tUIcZUxjbxXEx5qUQcVHoc=
X-Received: by 2002:a05:6402:1289:b0:50b:d75d:3155 with SMTP id
 w9-20020a056402128900b0050bd75d3155mr7696618edv.37.1685962726162; Mon, 05 Jun
 2023 03:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230605075823.48871-1-pbonzini@redhat.com>
 <CAFEAcA8fRWdFMrcy6G6yT-8320UZUf6QA9XO70f7P1ssraedRQ@mail.gmail.com>
 <814834c9-b257-8cdb-7372-35e689bc37ac@redhat.com>
In-Reply-To: <814834c9-b257-8cdb-7372-35e689bc37ac@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 11:58:12 +0100
Message-ID: <CAFEAcA-8rz_RXwfnxGE9spFrqdZNU5tp52Hnik-phUH0oUEwMA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix venv issues with Avocado by reverting to an older
 version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, alex.bennee@linaro.org, 
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
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

On Mon, 5 Jun 2023 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 6/5/23 11:46, Peter Maydell wrote:
> >> To avoid this issue, tests/requirements.txt should use a ">=" constraint
> >> and the version of Avocado should be limited to what distros provide
> >> in the system packages.  Only Fedora has Avocado, and more specifically
> >> version 92.0.  For now, this series reverts to the older requirement
> >> (version >=88.1) while leaving further version bumps to future changes.
> > If the new Avocado version is broken, don't we also need a < constraint
> > so we don't get it by mistake ?
>
> I expected those to be bugs that get fixed in 102 or 101.1, so not a
> reason to impose a strict constraint.  But you're right, the version
> that would be installed from PyPI is the latest; I didn't notice because
> I do have avocado installed outside pyvenv/.
>
> Is the logging issue limited to the one fixed by
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg962758.html?  Or
> is there something more?

I don't know, as I haven't tested with that patch.

> > In particular, for a local build tree that currently has 101 installed,
> > if the tree is updated to include these two patches together, will that
> > correctly downgrade it to 88.1?
>
> No, it won't.  What you can do is "pyvenv/bin/pip uninstall
> avocado-framework".

I think if we're going to revert back from Avocado 101 we should
actively do that, not merely allow older versions.

-- PMM

