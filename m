Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AD7BCF8B
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 20:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpYRU-0000dQ-OE; Sun, 08 Oct 2023 14:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpYRO-0000d2-Nd
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 14:23:46 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpYRM-0004oF-Ev
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 14:23:45 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-503065c4b25so5059994e87.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1696789421; x=1697394221; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3t8a4kXMmUtDJ5sTdqQkiCDCuTcdFY9WvXwO3toLRts=;
 b=D97K6CljlMHf+Eliml3nuIAb2GDj92dUwT6muaaJ9RdRZMeCydK34sEY9oYpLxG4+7
 DuvW9aX6WiytbGRRKCBsoTzuLMKRJOuZ+qJdSQSOPjlVv4jFFHZywsCsG8Z2CuLU726f
 iyuIc5ZWCnLfGb66QdUo1KX3TyaETCMiiahrbX70vIoRaifL/KapbyvSWzTV91Xswqp/
 DsS83KK/jK/EnePf8jakxarmHqVDnl/SELBadDFyTKVlwxv79WEB4c9IdSjRmKE2nczL
 ReaXz9lZA3EI/ZxCm8PJ/ljA12SkhG46wWKzXfvZm9exwDRC7fA27zEoSJK3PHnl3EBD
 62gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696789421; x=1697394221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3t8a4kXMmUtDJ5sTdqQkiCDCuTcdFY9WvXwO3toLRts=;
 b=VH6w7y+U4J85+Hbds56ADYEK69oAILD0JyzMf9q3NNdRkZDBh0fssR9zlEucZC82aT
 PCMYETQZlMRjep0z3ahpK66J7xIes7YusDozpidw/RKYRfetljWx1dReC8RF70CPJjcp
 qYKJZ/HeEM8QxjIngQc4Q+h24HmyjPFGuJB5M9P12U4GsFXlOdE+uddNU1hdKCn+l17P
 FFPLsFFKfb4+fAVqIZ30Ibk3SIwMUcrtMjD8q70KkKEXcNcS4grs1TWTnVs1Tf+71r5R
 VOzZlFeH14PTMWvHv/ojyfWqD2lNPXi2WSHVrT7wJoFZrPaKwf58BRjYCIYHkDExqHyV
 u96w==
X-Gm-Message-State: AOJu0YweUzlq7wpte1/tsZ64yxDkBJG/hYcuWkG23Fcf+33YqNqH6RE9
 ZZRoHrrsoclceMUPgMXcWq3oGQ==
X-Google-Smtp-Source: AGHT+IGkLvp/e/CbkUA5Dq7N1QJ6wMVPBbioChpKc5IvAXy9XH0ILmbrSLxe+ytWd6qLos4qoX7/Tw==
X-Received: by 2002:a05:6512:1326:b0:503:388f:30a3 with SMTP id
 x38-20020a056512132600b00503388f30a3mr12318251lfu.26.1696789421421; 
 Sun, 08 Oct 2023 11:23:41 -0700 (PDT)
Received: from localhost (95-25-89-116.broadband.corbina.ru. [95.25.89.116])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a19f813000000b0050307304a80sm1142264lff.205.2023.10.08.11.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 11:23:40 -0700 (PDT)
Date: Sun, 8 Oct 2023 21:23:39 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 lists@philjordan.eu
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
Message-ID: <ZSLzq33DgMNYBsQT@roolebo.dev>
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922140914.13906-3-phil@philjordan.eu>
Received-SPF: none client-ip=2a00:1450:4864:20::12a;
 envelope-from=roman@roolebo.dev; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 22, 2023 at 04:09:13PM +0200, Phil Dennis-Jordan wrote:
> When interrupting a vCPU thread, this patch actually tells the hypervisor to
> stop running guest code on that vCPU.
> 
> Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to
> hv_vcpus_exit on aarch64.
> 
> Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning very
> frequently, including many spurious exits, which made it less of a problem that
> nothing was actively done to stop the vCPU thread running guest code.
> The newer, more efficient hv_vcpu_run_until exits much more rarely, so a true
> "kick" is needed.
> 

Hi Phil,

I see severe performance regression with the patch on a Windows XP
guest. The display is not refreshed properly like a broken LVDS panel,
only some horizontal lines appear on it. My test laptop for x86 hvf is
MBA 2015 with the latest Big Sur. What are you runing QEMU/HVF on?

FWIW. I recall a few years ago I submitted a similar patch that does
something similar but addresses a few more issues:
https://patchwork.kernel.org/project/qemu-devel/patch/20200729124832.79375-1-r.bolshakov@yadro.com/

I don't remember why it never got merged.

Regards,
Roman

