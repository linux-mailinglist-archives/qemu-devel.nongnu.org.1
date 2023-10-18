Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6CD7CD6AF
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt20D-0000Uw-6l; Wed, 18 Oct 2023 04:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt207-0000Ae-JJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:34:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qt205-0004TU-PG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:33:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40839652b97so6477505e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697618035; x=1698222835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CqF8/Ybn68HM49A/EIpkgJLKGNG3vf15RWuCj+eAfPs=;
 b=USBYuLQEwdDX+aZwp9laqP+eFdHGmfPbso9zCuOhaaCN9mBIL9Ph1UdHOGFTJ215Nf
 2vbRArQSPxbtWuTeiT3sQ6cV0Y7fN49HuegbiBk88JQToQAimYak41QzMu6RbwXp9JUP
 fw2YmPBSp+HhODsYS9+/r7v/n9CmTuanMJUlOQeYlg+mljBy4Kaplr2FCMHhTgOFj5gE
 g5lVeukujJrD/Vt1N5c5G12+8tXmXF8iSw0hOEaOsT/L1asPrg0Lx0vnM3N3wsCAPNkC
 xdfDA2fsBMzS9zgEuVnzwy2t79wIbMbarsth4ltweDIbHcVWBs+SWf8dHQlPT4PrSqCj
 ffrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697618035; x=1698222835;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqF8/Ybn68HM49A/EIpkgJLKGNG3vf15RWuCj+eAfPs=;
 b=f0oCGik9IJ54TpoIKhDwCUmNp69Thr/cYVvmX3Cbp6go4/urhe9MYtOpMbpoKTMt6g
 zFZJkbgJIH9A+76psTp03rylJISlUV+QDt5EkK2x4Z9ilPh0wwsIvBKDD2XqueUiP6l1
 OxRiNoNAW8gdXp5262l6x8kODDIoLhtF6jTUEedWe26TDURyv+83l5tCWBS59dLbjNHx
 Glbz+lyW6pa34YbpUpCikl4NNnddK0dA8BzqpijwzMpFPsoVwLh7P6+M2gShoe893hlZ
 RpbP1GEQr3oTLR//N9HbnFsNvEcsYUQtitoNTTx8PXLYMCBrdwFMs4uwW+gC8o1fBzrk
 L76Q==
X-Gm-Message-State: AOJu0YwVnZEcZlV9RN/KYBdMnEGA84QV02Y9vttXROqx2uk75ioQ+2u0
 CP0KSwk4RP78jz/6XbXMh9SnVQ==
X-Google-Smtp-Source: AGHT+IElugPjYf+uD34GBP5UfVHsHh0m/66q1+OYfFlsoxh5LH2OtTsAEysMataM7zkreykrAADvhg==
X-Received: by 2002:a05:600c:4e47:b0:408:3c10:ad47 with SMTP id
 e7-20020a05600c4e4700b004083c10ad47mr898970wmq.40.1697618035416; 
 Wed, 18 Oct 2023 01:33:55 -0700 (PDT)
Received: from meli.delivery (adsl-21.109.242.226.tellas.gr. [109.242.226.21])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a05600c06d800b004064e3b94afsm1047329wmn.4.2023.10.18.01.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:33:54 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:32:40 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: fengli@smartx.com
Cc: alex.bennee@linaro.org, armbru@redhat.com, fam@euphon.net,
 hreitz@redhat.com, kwolf@redhat.com, manos.pitsidianakis@linaro.org,
 mst@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, viresh.kumar@linaro.org
Subject: Re: [PATCH v8 3/5] vhost-user-scsi: support reconnect to backend
In-Reply-To: <20231009044735.941655-4-fengli@smartx.com>
Message-ID: <2pugg.q0w0n9hlmdo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> If the backend crashes and restarts, the device is broken.
> This patch adds reconnect for vhost-user-scsi.
> 
> This patch also improves the error messages, and reports some silent 
> errors.
> 
> Tested with spdk backend.
> 
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

