Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A827457A1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFF8-0004x0-HZ; Mon, 03 Jul 2023 04:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFF6-0004ws-84
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:49:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFF0-0003TH-Do
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:49:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so4612645f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688374140; x=1690966140;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iI1clbq47bGe4M3H9zTt7lK6xvDHgJ+jX+ltK8XQGE=;
 b=GL6V+xctfqimN/im1iE3rkNNRqQ3Qn7dPlHg8jMeG6LzJTiO1iSELkEQA+uNJEmerW
 cxqE5OsWmA6qKk4/xB+3DknsxYgrM/6rWwzXB0BdDgkFabnaL0HPY+fKEqKBZnhlIn0H
 xHwXo1K4N8zdNm9BETgdiXfbNuwLOmzdGwZqvoHTd6HTrBlH/PHz1tTye4ZV1ICCyXgV
 yuyTkdDvIA/5bXfunvZ/sJH+cuNU+HVYu4syOpA8R2rObA4zD2Crl0KizOhdOZmsG4uO
 fvoHXc6dGn0QuDpuWv2CCBZZ6cJWGjzWAD9p+Ab9smMNTtb3IswonOLf1phpxXJ8NGn8
 SKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688374140; x=1690966140;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6iI1clbq47bGe4M3H9zTt7lK6xvDHgJ+jX+ltK8XQGE=;
 b=bMs2FWqtKuSZXESpVQ9HLCA0qFRS1TygwJMR3DC4FU0sKO+QsOPUF/os3g7UFtvkif
 lJXUJYP7gVz2YB53w9oYhTwIs4SOxR5pl7jCO6HSN2/vdKTq/xLduTOqMSRy8k2XV0Sr
 PcyKXAUlayAX99NFh/aYD3dE57EaEHe7CXA8ApTuRhTXbBr1WuBk6YPF8ikmMoXTAjAt
 fqr3zRXd9UuOH3yaMSk0Hppp7+eRNWrLO6ap4zf/wnl0FOaoGfCvjfCJemJYaDfo+kC3
 u4hx6KE6uq4o15pTWmgWabEk7DPsFv8KmJWvXt7tp0kbk20JbTJ6+RypPlTpJFPsSsp7
 snMw==
X-Gm-Message-State: AC+VfDwJV1KJICtalAUElcfpFQFjNNWbSnU/WM/oX3oiehErppEEsXY+
 AIGCs7Paf6Z/PWzAjWtw+eWovQ==
X-Google-Smtp-Source: ACHHUZ5VkR9QG1BpVumikPFAj28wcEKMWGiCTYAFiUIMbddUPrKwuYCzLsSe39lNU4ans9vcKSYN6A==
X-Received: by 2002:a1c:f70a:0:b0:3fb:c060:8b3d with SMTP id
 v10-20020a1cf70a000000b003fbc0608b3dmr7134911wmh.40.1688374140287; 
 Mon, 03 Jul 2023 01:49:00 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003fa74bff02asm26084331wmb.26.2023.07.03.01.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 01:49:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A105D1FFBB;
 Mon,  3 Jul 2023 09:48:59 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 02/24] linux-user: Fix formatting of mmap.c
Date: Mon, 03 Jul 2023 09:48:55 +0100
In-reply-to: <20230630132159.376995-3-richard.henderson@linaro.org>
Message-ID: <87o7ktjs78.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> Fix all checkpatch.pl errors within mmap.c.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

