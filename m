Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D180EB9D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:23:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1nM-0006fM-LA; Tue, 12 Dec 2023 07:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD1nI-0006d3-F1
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:23:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rD1nG-0001Jn-0M
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:23:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c46d6784eso19763365e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702383800; x=1702988600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wIIHLGf+FYM8dHAGzRr81fCvwMEpKX7fsSZdSMR2K4=;
 b=BXHqA2znYBKATPJEvQEnHNjEi3f+1giPi2yUMRVb3tHrRUPebJrnwdsw0EB2NuDdtD
 SYbNpBAMFUdkxYgmFulufHSk7ZBji8thdk30nJiKxO6Y7q1ODQYv42bAz6Gk8kPLiRje
 JjHQRpUbwY4/7uFhXJzXKdwwOKagXDtAQTh99QJMfVUIIu2RoCwjcXHGo1aF7ePa7mmU
 LYN19hiNdpUxxVz/lkaPKj2hH+bVd6fnyziIHH96ReFGLFSsFSjp1i3HGWVHGNcjpM+6
 6Blh+/vpv/9P8p4tOaSUh9Wz/VIBW0WV6HcNOK/m4G4q963Hw+H3zFVFl/1q8vOMuAdg
 LHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702383800; x=1702988600;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2wIIHLGf+FYM8dHAGzRr81fCvwMEpKX7fsSZdSMR2K4=;
 b=vr2GP8AfDv/lZcuXCsmmCIWP3wbL1lMnWLylS2jP9+mrDOvffa5lKG7supdAQewXVw
 q9SL2qBGS0QG2+TLIcihnoFqilHrSOnSigJuLfb3PNNZINcCOhVY9U5fdJHScqSOg0gw
 bh9hcgPIW35vafYNtGRkuzPwZ3uQ1SV7yRdQ1VtIDOJHCo9+vvISmUkBcrjnMRs/Z69x
 gHhxYBpuII/VzRXkFlRRUIcmvJVSPobageThGNyMBuZJ35+gAv3I0Rg7CwPfpJ9QM8C1
 vRpT2KDdreKXjuTs/Fb/wVsOE9dXyY7AVK8J2D1zuC45mZroKvUfIKoN9sknmTJTbpOS
 almQ==
X-Gm-Message-State: AOJu0YxEgAu+9bqpWm+dtolTvxU2kH0ZxKhMmqteFicD+co0WyrU+W8U
 Y72gB5R/OLGZ0lnYMeR3V7VwPQ==
X-Google-Smtp-Source: AGHT+IG9pWEldmns9zSLOVeumMNwXdQJJsixpFLGTyOchDzQJZmn/85lob5nBeUcoaV6yM4MJ0482w==
X-Received: by 2002:a05:600c:46cf:b0:40c:3d90:49f1 with SMTP id
 q15-20020a05600c46cf00b0040c3d9049f1mr2763360wmo.125.1702383800271; 
 Tue, 12 Dec 2023 04:23:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg38-20020a05600c3ca600b0040b540ff0a5sm16218442wmb.19.2023.12.12.04.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 04:23:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 911D05F7D3;
 Tue, 12 Dec 2023 12:23:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: <qemu-devel@nongnu.org>,  <richard.henderson@linaro.org>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH] accel/tcg: Expose translation block flags to plugins
In-Reply-To: <20231122121655.20818-1-m.tyutin@yadro.com> (Mikhail Tyutin's
 message of "Wed, 22 Nov 2023 15:16:55 +0300")
References: <20231122121655.20818-1-m.tyutin@yadro.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 12 Dec 2023 12:23:19 +0000
Message-ID: <87edfrd2yw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Mikhail Tyutin <m.tyutin@yadro.com> writes:

> In system mode emulation, some of translation blocks could be
> interrupted on memory I/O operation. That leads to artificial
> construction of another translation block that contains memory
> operation only. If TCG plugin is not aware of that TB kind, it
> attempts to insert execution callbacks either on translation
> block or instruction, which is silently ignored.

That was the intention - the instrumented instructions have already been
executed. The only thing that matters now is the memory access:

    /*
     * Exit the loop and potentially generate a new TB executing the
     * just the I/O insns. We also limit instrumentation to memory
     * operations only (which execute after completion) so we don't
     * double instrument the instruction.
     */
    cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | n;


> As the result
> it leads to potentially inconsistent processing of execution and
> memory callbacks by the plugin.
> Exposing appropriate translation block flag allows plugins to
> handle "memory only" blocks in appropriate way.

We don't want to expose internal details to the plugin. It shouldn't
need to care.

Do you have a test case where you missed counting the execution of the
instruction?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

