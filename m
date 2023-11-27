Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E77F9CEC
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:51:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7YFr-0004z3-RC; Mon, 27 Nov 2023 04:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7YFp-0004yr-Gy
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:50:13 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7YFn-0003Fa-Qg
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:50:13 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54917ef6c05so5370099a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 01:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701078610; x=1701683410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bubNYOYm1I0K983UoFPwOeMOv+VbYlQK2/Mi/2dUoSg=;
 b=PxPI36UCQhv8z53gnPYUdcrLSnQmz1FGoX7uDJK6o4be1BLhnFPzZ6HFZEEO5twVvg
 6CYzR3FzjYlckA1GeGvtqWP24HtWQ76TqSmOR6jHycLEmte0bphD6S/TqjyX1717xFf2
 kBDSjpp8/97mV1ALlN7CqRup2zxodTPDNgqZs34+JE0OAkB2IUfAGHE++x0i29m12Fh5
 5ZD5ZVJ+TYSrdMsjAStrozuAZLGCJIaf7mHnSl+NkVXaIaoCu13W2Ahadz6i8G5LCBWd
 cSzEuZbsZImzyWfMBinjdWaZzQsem61Zyi7pCWDNKwkZuhe3l1dVXV2OSGEHNnUJIQHx
 di3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701078610; x=1701683410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bubNYOYm1I0K983UoFPwOeMOv+VbYlQK2/Mi/2dUoSg=;
 b=LoW3vc1ocJxzULI5R0we/nl4OfCkBEp6eJk41ULHKAF/JaXMJxHTyVA8fTd614xHFF
 4qzAkxyKNgTscCXBxnWULIEn9QX/xIIVY2HwVJk2ZUTC8eC8fR4C/FKrlV5L/04WS8Ik
 KzcH3WiYaQiWnauODaWV3DKeQHVCDsZdRZiNgLpsWT2rvJg9arn//YFa+wiSe7ApY5A5
 ZNn4HQX1YmMT58IJCD07cdwnLI4BNCTV/8WNungry5/7rwu9IG2EHKeoG7J/5hfY/IJ4
 bjS6dFkTGKvQ3PVw3iBgn7Ox2vFDSS5DjgJXrhAW4YUDy25zpjT+Z0BeNF9CX63xXck1
 7F+A==
X-Gm-Message-State: AOJu0Yz/hneb1RwkdRKUe59F9dwG9J7PwlQ5aKk2VsAK6OtO0pXHGl6I
 7EepB0Vd5OxUs7EOnBC3rrGJvzhq/PmF+2iO+WgoWA==
X-Google-Smtp-Source: AGHT+IHmjFzJkYQHifyFWzoRSWdaEgpIFbHdESfS88VCrFinVT2QlsuukDbdrHedwqDNY6LRJPSY/1cYi1Ebso+KQNw=
X-Received: by 2002:a05:6402:3448:b0:54b:24d6:ddfd with SMTP id
 l8-20020a056402344800b0054b24d6ddfdmr4523033edc.25.1701078609955; Mon, 27 Nov
 2023 01:50:09 -0800 (PST)
MIME-Version: 1.0
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
In-Reply-To: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 09:49:58 +0000
Message-ID: <CAFEAcA-Z5ausxyyhkcZY6X=10sd1r502ASDmjFspra7wZK+83Q@mail.gmail.com>
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
To: Petr Cvek <petrcvekcz@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcel.apfelbaum@gmail.com, 
 mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 25 Nov 2023 at 12:24, Petr Cvek <petrcvekcz@gmail.com> wrote:
>
> GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
> The i386 seems to be impossible to distinguish, but i486 can be identified
> by checking for undefined __i486__.
>
> Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>

Last time this came up (over a decade ago!) we dropped the idea
because we couldn't find a consistent way of identifying
the no-RDTSC CPUs:
https://patchwork.ozlabs.org/project/qemu-devel/patch/1353683570-30525-1-git-send-email-peter.maydell@linaro.org/

We have already deprecated 32-bit x86 host support for
system emulation mode, incidentally.

thanks
-- PMM

