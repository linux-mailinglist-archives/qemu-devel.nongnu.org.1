Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46D70E202
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V7K-00075u-OS; Tue, 23 May 2023 12:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V7I-00075L-N7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:44:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V7H-0003Tx-7j
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:44:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso606785e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860245; x=1687452245;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NY8Elud5IiQRaHoWIWClkzgZY8rEqXBuKxkZDdqbGk4=;
 b=pGX1LW15f7m+lrqhaf+XgUqpZMKCrjDyCUR0Qh8zU02xHGxYuj1veKkYDJwgkkIYb3
 0SzklVTeXaSaYe2oKkd5EB8RcHzsnxH8BhMzjg5Rd/HETRD1ltMNuuKEzd1gWkg+jXeb
 te32bpQdXf3bdPnnQ8PdQSUP8iP4rE2LhYFtTNusuJIHaI4g1u2r7ip2NgHal+EUAJYb
 fisJX1NqF+2IBXNJ8I0HJ0M78amV0qCVBP86rBZD7qhVqTF+JcDsP4fPs4lKqPxVDl6M
 xrxfNYznmuH5dLP0TewuwhhaeEB2ha/+Co+K5SzYICEKBM1ooEJa+afnVaOwCn5as7Rj
 KZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860245; x=1687452245;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NY8Elud5IiQRaHoWIWClkzgZY8rEqXBuKxkZDdqbGk4=;
 b=ISdahD/w+X6DOCnHeK1YPnt5NCQ7RhDrgZvpdBPEmav3XlPxwQNgK5UErWH63fXgeG
 1me5XHD+4xLuSG54jJ5q0FYxPsfWHnRNAQVJiIvcasJFSihqElO/TC+mLBxpaRBcWL7W
 Tlo6fvYXTSbVXbFQOncVal/RI1vWyHmxjpWzGjbLGLSjGhk7Ko7fnDMvcfPNZn0/QgjE
 M9yO24CayylLJRKOZDXxPdNjhGd9kb2dCYq2LjYdphF6LIdeH3SusgIKFE4ulJer/v/L
 826g5k3TKQK5JlsBNltqV6N5/atipTUWNUNGwvMZYLLM4j6I3mIWuE27nuWGRQgSYRzT
 F8cg==
X-Gm-Message-State: AC+VfDy0k9EUKWrqGTebzN8k2jmQMacaBr+0ddsZkvYmnmabcgRvI+U4
 biHERu6E/Z0/vdVuJ+1ofdVHzw==
X-Google-Smtp-Source: ACHHUZ6900O1MPeJ1t+j9qoIXGWI9JU1LMmgGjYCLchDY8LV4zb89x9k9/tS5oQ29SxXoUFeBMZn5A==
X-Received: by 2002:a1c:c903:0:b0:3f2:549b:3ef2 with SMTP id
 f3-20020a1cc903000000b003f2549b3ef2mr10865711wmb.17.1684860245457; 
 Tue, 23 May 2023 09:44:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003f50e29bce3sm12188687wml.48.2023.05.23.09.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:44:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6DA91FFBB;
 Tue, 23 May 2023 17:44:04 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-18-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 17/27] target/s390x: Use cpu_{ld,st}*_mmu in do_csst
Date: Tue, 23 May 2023 17:44:00 +0100
In-reply-to: <20230523134733.678646-18-richard.henderson@linaro.org>
Message-ID: <87pm6ryp4b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> Use cpu_ld16_mmu and cpu_st16_mmu to eliminate the special case,
> and change all of the *_data_ra functions to match.
>
> Note that we check the alignment of both compare and store
> pointers at the top of the function, so MO_ALIGN* may be
> safely removed from the individual memory operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

