Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0D82B03E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:04:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvf0-00014d-K0; Thu, 11 Jan 2024 09:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rNvee-0000vz-0Y
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:03:32 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rNveY-0007MG-I5
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:03:29 -0500
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6dc36e501e1so3594220a34.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704981802; x=1705586602; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhZEwQP5COzWsQRvNuLuADGMgVWlNhHp5q21hdw8Uiw=;
 b=UEkuIPAB/oRN+zzEDiFex4Tu768fJ5DTTffXBFybddZlBzHhQDx2ytv9JWmz/hqb8g
 UoF8YT1dykKatfllGFUnMIqtBLGKme9+zMc/6bO6foM3A/KeAMAWoJ6Ou15aXfhGyv3L
 J05tSURTHVMRcMbWvsyUVdrrqjXYofwRnxfp2h3pqSUYoXflX2mPl+mX+3W/dhd0sB10
 VRcfmy1FDicJvw/+9fVFYkNO/7DCmZ0bXv5jfmylGpin0kaXCVLKzzjOq056lwZ1DHhG
 pMgZhBpTbTzJ1pxjONjFFidbj8G4onKxMxSu16lRw4grs57wO3/yzIJM+l+obzeix+ss
 NvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704981802; x=1705586602;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vhZEwQP5COzWsQRvNuLuADGMgVWlNhHp5q21hdw8Uiw=;
 b=hwymTgzF/dR/Uqr7q3KYMSMtT84yrBFB6z/A1lthY5dxErI9cI8fu1tG5FPt3OSC6s
 OLSgtPnfS9D2TuvmVmznHm1yrS2PRgRWUVOLVBvU3Yk8yk6O0Gb6GRCN1wBfXW4v2TfM
 17VLZKPrbADzOmzhCBI3Ukvt0pxX4PY8sLVtnP+2RSelWoMb2LhfND5K0835cOnDJlJI
 F4AbrpcUZXodqLbPPc3mBNGKebtvatMqYK0eebX3j3a8wyoEJOr26PS+qyNc/rBpS5/I
 WJehn1EkEaB93Us5DSSztQjUT6AWUyUibG5rZiR/1xzwNF7TcvGKVX4KNwOhKcZybFL7
 KFUg==
X-Gm-Message-State: AOJu0YzkNa5B7DdgGspEpCrNT7QyCSQwm8OONAJTF0TTa2drY94ZwW30
 Diai6wNbPdPQ3twcLZhurw==
X-Google-Smtp-Source: AGHT+IGU+wubVdNh727bV8aV9PuiZiLr4r+gmgzHhkoaq8H2eSDD3StwgbLXAgcsxbzhAxAmImZVdw==
X-Received: by 2002:a9d:4d9a:0:b0:6dd:dbbb:22bd with SMTP id
 u26-20020a9d4d9a000000b006dddbbb22bdmr1475593otk.53.1704981801670; 
 Thu, 11 Jan 2024 06:03:21 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.73])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a9d7f10000000b006dbac72c8f8sm165960otq.53.2024.01.11.06.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:03:21 -0800 (PST)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:a76f:f1c0:9761:3859])
 by serve.minyard.net (Postfix) with ESMTPSA id 7E0C51800BC;
 Thu, 11 Jan 2024 14:03:20 +0000 (UTC)
Date: Thu, 11 Jan 2024 08:03:19 -0600
From: Corey Minyard <minyard@acm.org>
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, cminyard@google.com
Subject: Re: [PATCH 0/4] hw/i2c: smbus: Reset fixes
Message-ID: <ZZ/1J4q1TEFmc72P@mail.minyard.net>
References: <20240110212641.1916202-1-komlodi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110212641.1916202-1-komlodi@google.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jan 10, 2024 at 09:26:37PM +0000, Joe Komlodi wrote:
> Hi all,
> 
> This series adds some resets for SMBus and for the I2C core. Along with
> it, we make SMBus slave error printing a little more helpful.
> 
> These reset issues were very infrequent, they would maybe occur in 1 out
> of hundreds of resets in our testing, but the way they happen is pretty
> straightforward.
> Basically as long as a reset happens in the middle of a transaction, the
> state of the old transaction would still partially be there after the
> reset. Once a new transaction comes in, the partial stale state can
> cause the new transaction to incorrectly fail.

This seems wrong to me.  In a real system, the reset would be done on
the smbus master and not necessarily on the mux (though I looked at a
few of the PCA954x devices and they appear to have reset lines, but
different systems may drive that reset differently).

It seems to me that the bug is the smbus master device isn't getting
reset in a system reset.  Just adding the reset logic there would be
easier and more consistent with the real hardware.

-corey

> 
> Thanks,
> Joe
> 
> Joe Komlodi (4):
>   hw/i2c: core: Add reset
>   hw/i2c/smbus_slave: Add object path on error prints
>   hw/i2c: smbus_slave: Reset state on reset
>   hw/i2c: smbus: mux: Reset SMBusDevice state on reset
> 
>  hw/i2c/core.c                | 30 +++++++++++++++++++++++++-----
>  hw/i2c/i2c_mux_pca954x.c     |  5 +++++
>  hw/i2c/smbus_slave.c         | 20 ++++++++++++++++++--
>  include/hw/i2c/i2c.h         |  6 +++++-
>  include/hw/i2c/smbus_slave.h |  1 +
>  5 files changed, 54 insertions(+), 8 deletions(-)
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

