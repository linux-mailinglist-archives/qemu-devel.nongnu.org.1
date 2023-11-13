Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6767E970E
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 08:28:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2RLz-0001x8-Fw; Mon, 13 Nov 2023 02:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r2RLu-0001wv-0f
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:27:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r2RLq-0002l8-4S
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:27:20 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso30504225e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 23:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699860434; x=1700465234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lmjTbaWwgNhRRWAMrLsXS+bGBAy4l4hG1zQoBNB7ZMs=;
 b=wY7M/NpjOI81B+mMSQwcNFv/Zfji6OvsLqTZvVDxJvIxv1gMKOh94GfgBtJci7Tx+1
 uTHutythS0Zloe0HIKzO8XlgE6hslFXofhS/FJTHyh7Wrpa/yDLs/o4YEfmtpopunOPa
 4Fz2QT239QU+rxGcJ1FX9BzXU2lzSRBvjL8bL3UWoRLSBiB3UWZufEukRonGla5gFZx7
 V2kutRg+yZZjokNUi4PSOZZeu78BXq8DkITWHplaOB1w3E+Chu6ePRNpNx5NWK0Rb280
 2ksC4QQAkqg4cEyUBR1VHiUxDSyUjENGfhQ4mRJvCelD4zUbrTSPnAWI++nG4Ry85pYo
 dPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699860434; x=1700465234;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmjTbaWwgNhRRWAMrLsXS+bGBAy4l4hG1zQoBNB7ZMs=;
 b=gSFvX7CFEJIyYpLpmo8WCX+BqpTBNxUINhDxOszYaZCgsZHNV0TPqGh4gwzvsu/lF/
 eT6Qh2/X4gVed09JqpaLUdBLfb4w9nVDCfwR8bJf2ko4COhe3ZWUgnGg9y+cFX0FtY1U
 M69AfeylVQcJHvi8sPW0Eiw6jfwuE0qgJ78uqF0E82/ruIPH2K0nKJr3x01ZvWcsVhOA
 UFUlC69kyzlt5EjFV/abBu/cJzv7J7qbDPBbl2ZLEd2dsxHhCSV6BYixWRfjh5DH8ODI
 m0v5au6J+WTdZWAqKGlRK3D6yK3LpaR9W5Od3oU6o5SmouGeIDPgWmeJekNbkCPI7pha
 QgCw==
X-Gm-Message-State: AOJu0YwYwtnzlCLxyCV6s8SNGFGogyxEzHg3HqL64UOYKSG7sh9mtRwW
 QVCSpm5CR70AHsAALv0qvY2smQ==
X-Google-Smtp-Source: AGHT+IG6nkKVAgxVm7ReDkTEGADdQoWARGncPoLlbwZ8tRQ2QjafWt7L4lyaO8it+011lPXzJnLzQg==
X-Received: by 2002:a05:600c:3b0a:b0:40a:5806:a617 with SMTP id
 m10-20020a05600c3b0a00b0040a5806a617mr434074wms.14.1699860434339; 
 Sun, 12 Nov 2023 23:27:14 -0800 (PST)
Received: from meli.delivery (adsl-202.37.6.163.tellas.gr. [37.6.163.202])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a05600c430800b00405d9a950a2sm12573125wme.28.2023.11.12.23.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 23:27:13 -0800 (PST)
Date: Mon, 13 Nov 2023 09:24:09 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Leo Yan <leo.yan@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v1 3/4] hw/virtio: Move vhost-user-input into virtio folder
User-Agent: meli 0.8.2
References: <20231113011642.48176-1-leo.yan@linaro.org>
 <20231113011642.48176-4-leo.yan@linaro.org>
In-Reply-To: <20231113011642.48176-4-leo.yan@linaro.org>
Message-ID: <41wpa.smmzo0kr8q76@linaro.org>
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

Hello Leo,

On Mon, 13 Nov 2023 03:16, Leo Yan <leo.yan@linaro.org> wrote:
>vhost-user-input is in the input folder.  On the other hand, the folder
>'hw/virtio' maintains other virtio stubs (e.g. I2C, RNG, GPIO, etc).
>
>This patch moves vhost-user-input into the virtio folder for better code
>organization.  No functionality change.
>
>Signed-off-by: Leo Yan <leo.yan@linaro.org>

Make sure MAINTAINERS is updated as well, it points to hw/input:

  virtio-input
  M: Gerd Hoffmann <kraxel@redhat.com>
  S: Odd Fixes
  F: hw/input/vhost-user-input.c
  F: hw/input/virtio-input*.c
  F: include/hw/virtio/virtio-input.h
  F: contrib/vhost-user-input/*

