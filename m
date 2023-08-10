Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6367781D5
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 21:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUBg3-00055P-UG; Thu, 10 Aug 2023 15:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qUBg2-0004y8-0w
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:50:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1qUBfz-0005gi-SG
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 15:50:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe4ad22eb0so11417925e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691697030; x=1692301830;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xZ/0qa3NSvcGehwzEfYsq9DfQlpGMzFLi1EENyQ/ChQ=;
 b=S/nzAr6dBVKocUB4FPxZbXIDPezZjhSA7ehpWHpRduueis7JRhnxK575jiNI9rRhW1
 AnExbHuYl0bOZAzzdFP0aXUUCWM8+D1wb/agYdq+GCLK457YhoDInbn9k/6NCrv2Vq6r
 h7ptjobWYOCwSK1/mPDvNtUQlYYuvax2rpVQXEYtWXtEh/i6c5GqeYZsB6SKIyKQBNk5
 mHeon00MYaaH2jYqvutcRniRkjbMgJIA+SURaZz8P2IjO5KdDLB6wUJC34iaaA0a/0L2
 o3S/OdbVKJdGrTiMgI4jmBU6Mh3NJ8NLv21K42Jomx7K5KVHm5eEijkjBLCEL3aafIGr
 vLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691697030; x=1692301830;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZ/0qa3NSvcGehwzEfYsq9DfQlpGMzFLi1EENyQ/ChQ=;
 b=jySKXwXDfAqJbi1sOJLeZjgl0flt268xHC2R7y5Eo+gNfEu136cZCOlWNYRAqVpKgF
 x4W5s/sHig3zieWr7eXM6XV5BSUe8yKX8p5/VNZryEpwemE+Blco3U7a4hIXJ9RodrJq
 7PJXtXj7aO2z39Wp7fX2WJ5q8tJMlifdyK61KI6hjajC0pDRIQbLORIOuauqwjB21SF0
 dX377/VUHKFz0gs9GA4hJwJ17oTCxDRqDTeoOHVT9r1Dg5sUqgFehIAcLVDn2YYNacMH
 eSIkcqzE/fyHl00vZ0Me5lR518TBtRSnYAwic8S1YUUwHKRH30+lF0OcyWU8DeTyyXeH
 hvLg==
X-Gm-Message-State: AOJu0YwbnsZHRkNgMBD5tIiPfh7MR4m1Q3CT7KOTrxdD7qGHd9viT2R2
 ru0BffHuGUg6/gWpglqmY/U=
X-Google-Smtp-Source: AGHT+IHB2JZ6WD5feshU3966iuVz4Fby6H3QK2UdwAsWCm+Y0gWYa0gOLJZO2xB+mRYuxJqlyOK+Fg==
X-Received: by 2002:a7b:c398:0:b0:3fe:173e:4a54 with SMTP id
 s24-20020a7bc398000000b003fe173e4a54mr2807740wmj.17.1691697029979; 
 Thu, 10 Aug 2023 12:50:29 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 z1-20020a05600c220100b003fc01f7b415sm5902582wml.39.2023.08.10.12.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:50:29 -0700 (PDT)
Date: Thu, 10 Aug 2023 20:50:29 +0100
From: Stafford Horne <shorne@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 1/1] target/openrisc: Set EPCR to next PC on FPE exceptions
Message-ID: <ZNU/hbdfbAOzp95u@antec>
References: <20230809203432.424071-1-shorne@gmail.com>
 <20230809203432.424071-2-shorne@gmail.com>
 <a5dc02df-158e-4ff8-fce9-e2ec7df980ad@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5dc02df-158e-4ff8-fce9-e2ec7df980ad@tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 10, 2023 at 09:35:18AM +0300, Michael Tokarev wrote:
> 09.08.2023 23:34, Stafford Horne пишет:
> > The architecture specification calls for the EPCR to be set to "Address
> > of next not executed instruction" when there is a floating point
> > exception (FPE).  This was not being done, so fix it by using the same
> > pattern as syscall.  Also, we move this logic down to be done for
> > instructions not in the delay slot as called for by the architecture
> > manual.
> > 
> > Without this patch FPU exceptions will loop, as the exception handling
> > will always return back to the failed floating point instruction.
> > 
> > This was not noticed in earlier testing because:
> > 
> >   1. The compiler usually generates code which clobbers the input operand
> >      such as:
> > 
> >        lf.div.s r19,r17,r19
> > 
> >   2. The target will store the operation output before to the register
> >      before handling the exception.  So an operation such as:
> > 
> >        float a = 100.0f;
> >        float b = 0.0f;
> >        float c = a / b;    /* lf.div.s r19,r17,r19 */
> > 
> >      Will first execute:
> > 
> >        100 / 0    -> Store inf to c (r19)
> >                   -> triggering divide by zero exception
> >                   -> handle and return
> > 
> >      Then it will execute:
> > 
> >        100 / inf  -> Store 0 to c  (no exception)
> > 
> > To confirm the looping behavior and the fix I used the following:
> > 
> >      float fpu_div(float a, float b) {
> > 	float c;
> > 	asm volatile("lf.div.s %0, %1, %2"
> > 		      : "+r" (c)
> > 		      : "r" (a), "r" (b));
> > 	return c;
> >      }
> 
> Is it a -stable material?  It applies cleanly to 8.0 and 7.2.
> Or maybe it is not needed on older versions, not being noticed before?

I would say no, it will work on 8.0 an 7.2 but this code path is not very useful
withouth the other 8.1 Floating Point Exception handling updates.

-Stafford

