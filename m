Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F346A70E28A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VMP-0002tT-9O; Tue, 23 May 2023 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VMN-0002rF-Bx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:59:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VML-0007mv-Qx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:59:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f41dceb93bso833645e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684861180; x=1687453180;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMcEk5XAqp7Vm6XpBgnhKbi0LOXoiRCObtJuOF1xeQQ=;
 b=FGraGE2gIeYwZ6HJNM5WSkp97onDR9uD+3hVajkaD30FcYBDABmezlCw219IKOvdj/
 3Ml8xisQY+MS4FKpjrCiH8jYnyVAjdbUxXr+0GTo94KxceuwJ8ak657OgDVa00fKhlQG
 pg+tacc9cs9uLbnuzXkjQiydNS4vFNToO0alz2OdgP7L0oaE75Cit+BCHXGShwSxh3wD
 xvN7CwORIwosq9OABsEMRcLhuIK396+AIofCGMrIpDgl9TwVVPl2ZgRln9j60mzge1KB
 M+2DoQ/t4HXV5iUYtOtS8dRgxJxTbZ3pWMwgllXho4cU7PEycVO5v0VTsTStrxhcRZbf
 sJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684861180; x=1687453180;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FMcEk5XAqp7Vm6XpBgnhKbi0LOXoiRCObtJuOF1xeQQ=;
 b=H/wTMSWi/hrCOsnauFB3iZmo4NIAGivdAafJ6GuhrJvA6H7HkmxIFUiOJ8V36kjVIt
 JZFDFkrEmlOMeoHmzxzUGZrejwcVPTh3CHJuVyEMBKYbeD70LmGpR7L7IDqJtLkVtWNX
 q+o798YuRoG1xwzIUGBbUY0wev7YSRG4mXiKRPtdpccB8Ghk6ezgbYpfZOc1BG7xEWf/
 //8h4m36epLGTLSLw1CKMfpMPFBPvTcqYt/0znab9W2Muu4ip4KLU04fkNjFxgPOqBmF
 9X5pC9B9Dn3p0rwoEdzZNFipJd0OGl0Fm2SzIinApa6izQw+zRVGy8e4NaSJWEGV8EDU
 3krQ==
X-Gm-Message-State: AC+VfDy1KUkM3tkJrbTkAtzk0DnMx0BRXtr3UkiGUvmQf+oJXuKrG1EK
 /ZD6rd5qPkt7XuoeHEU7lWjI1A==
X-Google-Smtp-Source: ACHHUZ7tsmKXw9VFGAwjwhHCW4+MiOJluKRVYLLZ8rsAwRxhSaIU01XprYMAHQR2TzBU3sbIotoY7w==
X-Received: by 2002:a7b:cd0c:0:b0:3f6:7e6:44ea with SMTP id
 f12-20020a7bcd0c000000b003f607e644eamr3583910wmj.18.1684861180323; 
 Tue, 23 May 2023 09:59:40 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c024a00b003f42cc3262asm10509528wmj.34.2023.05.23.09.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:59:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD82F1FFBB;
 Tue, 23 May 2023 17:59:39 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-16-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 15/27] target/s390x: Use tcg_gen_qemu_{ld, st}_i128
 for LPQ, STPQ
Date: Tue, 23 May 2023 17:59:35 +0100
In-reply-to: <20230523134733.678646-16-richard.henderson@linaro.org>
Message-ID: <87ilcjx9tw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> No need to roll our own, as this is now provided by tcg.
> This was the last use of retxl, so remove that too.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

