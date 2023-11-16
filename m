Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E307EDC22
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:44:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X2C-0004Sd-5B; Thu, 16 Nov 2023 02:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3X28-0004SM-Pj
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:43:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3X27-0004eA-0E
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:43:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so3900425e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700120605; x=1700725405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+NNIGk1BbT04LW21JtEAOLl2RjS7aaSue29bqXYaceI=;
 b=VmGoTtvxxXF6NXtfJH5Mqp5XZDJ+pkJLfV24Ni4kG7guE5+4FOU8LDDufMEKGHNwhv
 WS5u5Io8nXJmdBdIHIwfgXkOV4hd7Qy6tAmfi1FslSUAF/ImGiWKJSNflRCF7Y3bdZ5A
 o87/HIwP9NSUTmP0sf9yQ1Ga2kZBIvwjT4hstHdtVXlCLqQf+Jl5M7njQeHcIAAxXoAv
 yxqnhpJPQ2VKUoXZS+SeC5DNWGsd0R+4gAZbs3oRS5ZMvhsw1uI+aHIsLS+J6jtDZLuT
 aUMVZknYxVyPABA4XtN2VvzV0mqUADKY5JBltRaZCqoF1vHLCt9a5i7b1bB8g187xlks
 l26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700120605; x=1700725405;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+NNIGk1BbT04LW21JtEAOLl2RjS7aaSue29bqXYaceI=;
 b=U1rohK6rKIfO7OIRwm+3f0Oxe/5RxKku4ahN4IWHtu7AaLPhfC36xmkW9bmwLo7rn8
 rrvvyaB0ylwt0B+gz4etZg4l5cuxfBte8yqIT2SJ47DxHUtM5ezHD26VgpWUcSWrM3A+
 uA3in7EKnty4raVXNa68t7fX9f8WL7arNLaXT6DdV1VFWK+OMI61yoD1Mg2ezabRGPbd
 8lsugkj0Up3L9n0lFmHWVNY4AdjvLggd7WemaxRKpD7bKnmQDlUtjF9us+XflGpR6x3v
 qahe00M6Wep59AmqJANMEP9cqUoGKHe7yQ7CpzYeTLbTgH4itIby9SDr06Jwzx+mBR6v
 EuWw==
X-Gm-Message-State: AOJu0Yziu4ILWpgLYWY/VIknJPelngNx02uoi+CMG9hP9qk89prd9iwb
 yqBSBEjibTo/03OJJc5RcWAO1Q==
X-Google-Smtp-Source: AGHT+IH6rJ2TpdyxSGAFrFlVem7wwjCIC3+vCWdd91iqhMZV2FHlLVvG7F19DHTkQAWHR00QaIQ3/g==
X-Received: by 2002:adf:ee51:0:b0:32d:a717:717a with SMTP id
 w17-20020adfee51000000b0032da717717amr11708423wro.40.1700120605324; 
 Wed, 15 Nov 2023 23:43:25 -0800 (PST)
Received: from meli.delivery (adsl-149.37.6.3.tellas.gr. [37.6.3.149])
 by smtp.gmail.com with ESMTPSA id
 b6-20020adff246000000b0032da40fd7bdsm12682536wrp.24.2023.11.15.23.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 23:43:25 -0800 (PST)
Date: Thu, 16 Nov 2023 09:41:29 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: virtio-sound segmentation fault
User-Agent: meli 0.8.2
References: <1444ddb7-8a77-4918-997d-c4ed6a6273ee@t-online.de>
 <04ed8955-81eb-4cf1-8a5c-b14eb127831b@t-online.de>
In-Reply-To: <04ed8955-81eb-4cf1-8a5c-b14eb127831b@t-online.de>
Message-ID: <47hgb.tcsnrfscnu2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Wed, 15 Nov 2023 22:27, Volker Rümelin <vr_qemu@t-online.de> wrote:
>Cc: qemu-devel
>
>Hi Manos,
>
>it's easy to trigger a segmentation fault with the virtio-sound device.
>The basic problem is that in function virtio_snd_realize() there is no
>code in the errror paths to undo the previous steps.

Thank you for the report Volker! Patch posted:
https://lore.kernel.org/qemu-devel/20231116072046.4002957-1-manos.pitsidianakis@linaro.org/

Manos

