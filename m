Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00F837473
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:48:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS1Ci-0008V7-A0; Mon, 22 Jan 2024 15:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rS1Cc-0008UT-Nk
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:47:30 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rS1CZ-0005db-QY
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 15:47:30 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cd853c159eso42057261fa.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705956444; x=1706561244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vLRy6pGNsndsgSO6Zt3UBnLSBcFirLCyCzG+Tmfc8Bg=;
 b=C3TcpqxU1jm50ngQtk0PxfK0v+7bzB9w8NxZ+8cveBWhAbvbApz6gzKPbKdr59SvSv
 3uprzZ3lPLl7HEsso33wUfK8HYJ+TDZPikvclhBQcalqtrqQrcsiidvhnDsCAPHLtZiW
 CPu4plMR3+Vsv3RCmiXepPm8elCmjsUjFeRxOx7X5qtH5X2FfdDL43XVBoru27Go8LWK
 9h6GVm14pYcC338z0uO6IUXZK4abIrS58S+zTa11wzTJCXVWZnnwMURRkXszW8O19zyb
 /0fqooogeCL82gQ0atIfR1/04qdmWtDKOP4ORrSQ2xwY+/wQqCoUzJy3l4m5I1emBhH+
 Q6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705956444; x=1706561244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vLRy6pGNsndsgSO6Zt3UBnLSBcFirLCyCzG+Tmfc8Bg=;
 b=BLvyz70q8SUE6ggDSjU/z9+JtDsX5PK2MxskeDsPrjOmvXN9yO7jib7ONOmWJgy2YR
 7zlxAtF13AD2f5VRgDRff7N+yF2+mjwyKz8kTWrKyvKJEDjIpvP/sH+s5fselx7rLv4w
 l87ISuapOQmOvuvYqu6m4nqah7h00Z7WTJIRS2nWhiZLcUpoXoIKQYGPnlMFxaX/BQWj
 VIEmReVsLhBxmLuVR0wtyBq839KBVx1MM1M2b3lm8kVVz57FmQQQC+fNZEuOL9TFbIU1
 C813AR74BWl+Qjbm5IqgBZ1hi8Q7t5bYlaCHHxknmyFynHeun5HgYwFJQO+ZX8f7zmxt
 RUHg==
X-Gm-Message-State: AOJu0YxzkfT25gqnkj8E7fcTLQPaSxUl+EonKeNG0bJbsmjHKRDlPkth
 6EOHjTA9Z19zIpr79RiQeouaEl9p47F3gf4uVz0rbBWxyQaJA8FODytXGEgvlYPlHjeZYXNZuyQ
 cKojYTAaIl5huhBUT3P7UebpZb6RLnsOq8cmNqQ==
X-Google-Smtp-Source: AGHT+IHiSGcDqXCL5S7wApV9epxHHqPyArL9eohHfhU2siiTzZ7dwi+Ri8kD83GhY/UbF8kVnZlZZYlgGr4DhmTA87A=
X-Received: by 2002:a2e:a98f:0:b0:2cd:50a7:12d0 with SMTP id
 x15-20020a2ea98f000000b002cd50a712d0mr2705129ljq.38.1705956443978; Mon, 22
 Jan 2024 12:47:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40m=_7zOT5bnp1FR12ohVbm-miUorh6+rrk2Rwd1jArR1VA@mail.gmail.com>
 <CAFEAcA_ZyphRxH59VHEpnS_8D4YuBFSZeODwRbMjrqhkggD-Cw@mail.gmail.com>
 <130d2f10-4165-4d35-ade3-e6080e2a109f@linux.ibm.com>
In-Reply-To: <130d2f10-4165-4d35-ade3-e6080e2a109f@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 20:46:51 +0000
Message-ID: <CAFEAcA-k8MF6f6fAa8Hn1B8z4H-Ott8d7G1tZRqxVtQyY+O9og@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Exclude TPM ioctls definitions for the GNU/Hurd
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Manolo de Medici <manolodemedici@gmail.com>, qemu-devel@nongnu.org,
 bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 22 Jan 2024 at 19:30, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 1/22/24 12:16, Peter Maydell wrote:
> > On Thu, 18 Jan 2024 at 16:04, Manolo de Medici <manolodemedici@gmail.com> wrote:
> >>
> >> The Hurd currently doesn't have any TPM driver, compilation fails
> >> for missing symbols unless these are left undefined.
> >>
> >> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> >> ---
> >>   backends/tpm/tpm_ioctl.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
> >> index 1933ab6855..c721bf8847 100644
> >> --- a/backends/tpm/tpm_ioctl.h
> >> +++ b/backends/tpm/tpm_ioctl.h
> >> @@ -274,7 +274,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
> >>   #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
> >>   #define PTM_CAP_LOCK_STORAGE       (1 << 16)
> >>
> >> -#ifndef _WIN32
> >> +#if !defined(_WIN32) && !defined(__GNU__)
> >>   enum {
> >>       PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
> >>       PTM_INIT               = _IOWR('P', 1, ptm_init),
> >> --
> >> 2.43.0
> >
> > This looks plausible as a change, but looking at the history
> > of the file in git it seems like this is a file we import
> > from a third-party swtpm project.
> >
> > Stefan: should we get this change made in the swtpm project
> > too? Or have we diverged from that copy of the header?
>
> The diffs are minimal at the moment:
> $ diff swtpm/include/swtpm/tpm_ioctl.h qemu/backends/tpm/tpm_ioctl.h
> 15,16d14
> < #include <stdint.h>
> < #include <sys/types.h>
>
> Since we already handle _WIN32 we can just take this case for __GNU__.

OK, so how should we handle the mechanics of it -- just take
this commit in QEMU and then you'll sort it out in swtpm?
Or do we need to change swtpm first and then sync?

thanks
-- PMM

