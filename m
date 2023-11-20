Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9537F0B98
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 06:36:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4wvf-0000Iz-Tk; Mon, 20 Nov 2023 00:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r4wvd-0000IQ-Py
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 00:34:37 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r4wvc-0006Uw-95
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 00:34:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40859c464daso13075025e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 21:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700458474; x=1701063274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TrDZQH953bXoccs22DlUNEJLedfd1SrBIWvdIXhnzrA=;
 b=wYO1QsWt+g+WMe45NqDKYqHIDjkuFNSe1QfCKfb4joPPdDSM8HL8dwYPpKB2BL3D4r
 bD/t5doxSwKU9dlNrbK5WB2yf5QAZixo0bbjSs/inhBZkABgBmXUm58isi+XnV++8tbd
 cIyBoBF8YPrUNqVSoOJoZSZe10AlZ3oTjvPLLuMJlXlRcduJUecXd9HGxTPos2edxlrp
 VqgRWqTW4icn9QXAZsSmMnzvO/3Idox3boBVfn5erRxm+zMrTf3CGsln4VvKrcD339jI
 RWiOKD/lJChwYF05l1aZDEVRIeA5UYtkxmP44gn04uhQ4568D7zsCKTFCl6sWNXcASBs
 dUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700458474; x=1701063274;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrDZQH953bXoccs22DlUNEJLedfd1SrBIWvdIXhnzrA=;
 b=RgJaWiSqScGmv5jrlMftVDNBgNekv/KqObxrjk9Sk49+7bzkJDtT/JCSaTVuiwb0gN
 0dNTyTcaUx1aneXkAO0HJweba1eelFmYnj2o+MW8uIdlhw1451OAGQuCiDu1XnXM27re
 E5ReNuiDEEJec8hPEwCTAEWUTJRUM3paolA+TYZuHLKh8tXoa65mjsXFSErq64eFk/4h
 1q32dMJgK3vOKhccrCPcynMStPF7EJo0chZEorDpkwKPB/JCym83uSdWo7/OyX0T2GNB
 y9JFwbEPVpk2hneGDYeKoKgY5WqTrMPXJZdePxwkwWHZJzfZEGNdKxnThC3J5XAtm6F4
 2F6w==
X-Gm-Message-State: AOJu0YwR74s5C2zIIHrcBBxkD+VZSZcEJQk/YGw7BDHw8PmPIx2iQdnW
 qS/93S18ZW0rL3yVNX22NSZOUQ==
X-Google-Smtp-Source: AGHT+IFU8KKN9sOudLLBsxvI948bKaETieuNVjCF2tr3Bpe4uSKfIRPTlicyMpr6tnK71Tz9cjdglQ==
X-Received: by 2002:a05:600c:1d97:b0:405:82c0:d9d9 with SMTP id
 p23-20020a05600c1d9700b0040582c0d9d9mr4479044wms.41.1700458474490; 
 Sun, 19 Nov 2023 21:34:34 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 n27-20020a05600c3b9b00b00405959469afsm12377563wms.3.2023.11.19.21.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 21:34:33 -0800 (PST)
Date: Mon, 20 Nov 2023 07:20:23 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Leo Yan <leo.yan@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 4/4] hw/virtio: derive vhost-user-input from
 vhost-user-base
User-Agent: meli 0.8.2
References: <20231120043721.50555-1-leo.yan@linaro.org>
 <20231120043721.50555-5-leo.yan@linaro.org>
In-Reply-To: <20231120043721.50555-5-leo.yan@linaro.org>
Message-ID: <4eq5j.t42akv3xo7oa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Mon, 20 Nov 2023 06:37, Leo Yan <leo.yan@linaro.org> wrote:
>This patch derives vhost-user-input from vhost-user-base class, so make
>the input stub as a simpler boilerplate wrapper.
>
>With the refactoring, vhost-user-input adds the property 'chardev', this
>leads to conflict with the vhost-user-input-pci adds the same property.
>To resolve the error, remove the duplicate property from
>vhost-user-input-pci.
>
>Signed-off-by: Leo Yan <leo.yan@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

