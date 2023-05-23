Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0E70E288
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VLv-0002A2-Ke; Tue, 23 May 2023 12:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VLt-00029l-IZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:59:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VLs-0007cW-53
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:59:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f611ccd06eso102505e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684861150; x=1687453150;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I55zlkXwKJx7AIfjIVWzREvUsaMKUS3enVR2Un9iNZE=;
 b=w0huiYgEmw1mvtckK3h3ua4znFsLmdhz+tXH5H2bCJ17QQWJMV95pebPyKezk7WOhQ
 QFBDSs8CwM8oStUjUUldOmzyrqt2+N+ClzzrpZddamHwmNKF18fv0sckc2xm8jQRI0b9
 BYnjpuR7N1rUFLQmXNt23ZmTfowz8xPVhUaMy9L/ZAAIWua0ZTWFIVliU/ISws4Rnme4
 zYBstPfFLfeqW5pnhwR3wEpY7TaJViqcKSHcXQhDcCbEo+Qkmh8qhlmOsvYcc4EArNCt
 o4oQi9ztWByi4ikno4jOSOj1HhgFCB57d6R1jXtERN0PvF4DbVAqilBV17XZex55qVrG
 QW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684861150; x=1687453150;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I55zlkXwKJx7AIfjIVWzREvUsaMKUS3enVR2Un9iNZE=;
 b=MHFmYQ50NQAvGddoNPJH8X6oZSJ5gNAiAjMqjIPOZIrbJ3xnfWGujRHkKJGi0swhrf
 EpqQOa6S7zktfvksyavu5kXarBu9MryMmvD3KSkyphMcQTml0HDWK8PPS5EL8jJ911B4
 y/LhD9+dXDx0HCrulYoVOvfZ1cc+JxFWOUA/oZq63yp2uxDnuquEiecqWWaCpEbR7M8R
 U7WGbal0sihGVpZJCyxtDc0VgEZcFWUmR1nnrSBiCPZeSOHIsULjvgD997WpeCo08BCd
 w8e6nL4zaZPs4oqI9wxgyD7lEVdtFXJvrv5YqyiBj9CLFhpIIwUniwNnaJBx/gS1LIKa
 J1Kg==
X-Gm-Message-State: AC+VfDyvdurs4fcpVnW8bVTWvTlGts/CuLV2BeU3o2Wmb4mnmMTIa1Bc
 6h8nIU5OBOdHifKZadwSELGgMA==
X-Google-Smtp-Source: ACHHUZ69rUoqYGFKyxJi8z2pGOe1T1zlOPUnU0o1CPbHu33+1HGuKYSDZwDzj2Vuaa3sJP5aQxi4ng==
X-Received: by 2002:a5d:58d3:0:b0:309:491b:39cc with SMTP id
 o19-20020a5d58d3000000b00309491b39ccmr9798729wrf.3.1684861150637; 
 Tue, 23 May 2023 09:59:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c11-20020adfe74b000000b00306281cfa59sm11795456wrn.47.2023.05.23.09.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:59:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0ABD71FFBB;
 Tue, 23 May 2023 17:59:10 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-28-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 27/27] qemu/atomic128: Add x86_64 atomic128-ldst.h
Date: Tue, 23 May 2023 17:59:05 +0100
In-reply-to: <20230523134733.678646-28-richard.henderson@linaro.org>
Message-ID: <87mt1vx9up.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

> With CPUINFO_ATOMIC_VMOVDQA, we can perform proper atomic
> load/store without cmpxchg16b.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

