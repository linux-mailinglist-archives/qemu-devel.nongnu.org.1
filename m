Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E870E1FE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V4V-0004zI-63; Tue, 23 May 2023 12:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V4I-0004rm-SX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:41:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V4H-0002za-3E
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:41:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f607766059so470065e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860059; x=1687452059;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Uqvle8DSyh3g+dcv75ZaPlh2/JROnQwDtYnEVva7Cc=;
 b=l7cku3LKMGt2xNmzLn2nqzHpzmZXJMaRK6ZFicrhHNWgkmzWHhbLGP69dfrM2iA19Y
 N0AS8cCVXyTzQ9jJvDDkE3g2a0M8ptzWsPVLSY2dIrjho1094BawtxPpHVLNEexL01bV
 WXCr6I5DUM0rFNra/JCEmfAmbV7bt7Eap9ECkbDrL61Hwz1GMtmLPq2OHqhwi16XbGyZ
 DYcKBm2x3BdMGttfUAni0URqS2pRvxAiDIQdiKYwylq4xMcjVHGziuPiPNmSJJwA2mtN
 YCa1Q3Gm1CPEVmd3L8CTHTmwcis6sRY3iEVw79W3C4LzKzHQIlgg+JWIbDM+83mOp8sD
 U5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860059; x=1687452059;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5Uqvle8DSyh3g+dcv75ZaPlh2/JROnQwDtYnEVva7Cc=;
 b=AQ0KPaL7ij2KkELE73Vdep7x0wG3Aw+H2rYoxw3u2NeBhEYkYaoCU+5kq8Y54fXXv0
 5QtnDLrYbU2ztRgkyqitfQI/1KZ9PsY9Z61rxmfT9JqDDyfvdTDtUPXoTSavWsDtFFWq
 930rxaNEYLJrAx+EALbfk+geXHBrRc8DXApU46ho23+lFqzhBPjLSYDBPUZepJdLS9zT
 oBjG1vTXy0lGwWgUAKPBFQMMGbbiQfm6Efym+QlEOQVzv6dikUGXxHt8R2F7envNt1DD
 PCcRfm3h8vPlmXnL34C5eXvx6rD0KQTWGXPbmF9ZI5QZmPDf6MxGFjonoIwDj7hu7KxH
 av/g==
X-Gm-Message-State: AC+VfDzQ3QE5TeAwi2geI9A6YBn39V+m13c/dAj/OX/Rn1qtPimsFe9q
 gFkEsUrqJpYlToXgmOuahzRpF/ndUuKZ0C+P0lCehg==
X-Google-Smtp-Source: ACHHUZ675GBGpI1IHiGy4uu+Z44ilapgW6B8lzpUZKbHM9YioFxOMzuwOgAD1y6ujI+/Y5RaMNCyhg==
X-Received: by 2002:a1c:f30a:0:b0:3f4:f012:5cae with SMTP id
 q10-20020a1cf30a000000b003f4f0125caemr11385582wmq.20.1684860059527; 
 Tue, 23 May 2023 09:40:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c205300b003f60101074dsm10237328wmg.33.2023.05.23.09.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:40:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB4291FFBB;
 Tue, 23 May 2023 17:40:58 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-19-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 18/27] target/s390x: Always use
 cpu_atomic_cmpxchgl_be_mmu in do_csst
Date: Tue, 23 May 2023 17:40:54 +0100
In-reply-to: <20230523134733.678646-19-richard.henderson@linaro.org>
Message-ID: <87ttw3yp9h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> Eliminate the CONFIG_USER_ONLY specialization.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

