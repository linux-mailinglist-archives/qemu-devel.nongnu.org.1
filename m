Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1471FDAE
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q50zg-0004K0-Rf; Fri, 02 Jun 2023 05:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q50ze-0004Jg-6c
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:22:46 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q50zc-00028M-9h
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:22:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-514859f3ffbso2666033a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685697759; x=1688289759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6wokpUFI3AgXD4Qn5C9gRNCiQYNa0dpDpjwuSa95I4=;
 b=xi/FlkKb+M7LlR0pDXTZxCVCSRTsvNhM17VgfSJVZcNTdYgtWjQ5XDrrz5F6Zeg6Ur
 CwgH8BXjz6LuHRzhRW34nf9E5jVDb4y2TNBU1UN7IqyrnJa6YsBf6vqKSBhTr2GMcYLJ
 pTEBVD7J9Hqi2j55Wf7i0zlV4Dfla0rhbGi+xUKWRQKG+7EivBqO1I2rVAAryk/Deqps
 DivLrAMUDXAftPKyGUSLK9JEYOUDz5DojcCCVZ2gQAc93IgcWxoVVjhZ3XefY37mIDf2
 o0QDFDxKZoVUCMxSnK8W3RAS15hRbgu1gw80HjezEz0EJ1l+Uh33giTbfB/MKnGZtbYe
 uraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685697759; x=1688289759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6wokpUFI3AgXD4Qn5C9gRNCiQYNa0dpDpjwuSa95I4=;
 b=ZCdNMgyxiafTvIZ0xtokzaX+jB3qVBzgmdlsR+FBslNs578F3jy6PLpBZPbQlBj8x0
 QhSWF7En7n25bVNmEyzSrogCNEqmKyT8fj1NInKY+ewqTM1XiOB1BnZWlulnD8NpI/Yq
 ydYdLms9denY8Mm1LcleJA/2ooqOazt4NJjdBGgRT/8Iy70oUlIerE0kQ3ejQqavVmqj
 jueC69bAdsQCxk/k476TQ/z2WDMiv8AfbdpidEZpJjQOc8u/X0e9u9MDQRpNA4xlBgLn
 hAE/oYuNsLYbVIK6CfPwx0fUqOQyxTCi41s2Bn3mx0SYFiTc9reZgBjh6MbeVV2iwOgk
 BF+A==
X-Gm-Message-State: AC+VfDyOYyLYkgDKvfSPB9WgpoJCYZSVM0HoQZY9B+4jcKq/utbM/K0u
 uzfqAtg5v94lzsNktVYFhilB5AXYr2x0WyLYLIKtKg==
X-Google-Smtp-Source: ACHHUZ7fR7tCRd0/tyEqAub7wYzB8pVRX7Nu2RrFWK4RVlIseyMXLzCv298SEnrkSIZXo9Ovh0QjbeO3zIPqBWN856g=
X-Received: by 2002:aa7:df81:0:b0:514:a5f0:93c4 with SMTP id
 b1-20020aa7df81000000b00514a5f093c4mr1409220edy.14.1685697759192; Fri, 02 Jun
 2023 02:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
In-Reply-To: <ZHmyA40nIiUBceX0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 10:22:28 +0100
Message-ID: <CAFEAcA_1FF6tBt7C=zfLcSiFPNzSecZkRMtppYbUBjwZPVfbmg@mail.gmail.com>
Subject: Re: Big TCG slowdown when using zstd with aarch64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 2 Jun 2023 at 10:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> I suspect that the zstd logic takes a little bit longer in setup,
> which allows often allows the guest dirty workload to get ahead of
> it, resulting in a huge amount of data to transfer. Every now and
> then the compression code gets ahead of the workload and thus most
> data is zeros and skipped.
>
> IMHO this feels like just another example of compression being largely
> useless. The CPU overhead of compression can't keep up with the guest
> dirty workload, making the supposedly network bandwidth saving irrelevant=
.

It seems a bit surprising if compression can't keep up with
a TCG guest workload, though...

-- PMM

