Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050876EFBB
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRbMj-0008AW-S0; Thu, 03 Aug 2023 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qRbMh-0008A5-AX
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:39:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qRbMf-0000pm-R6
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:39:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31765792c7cso1074677f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691080792; x=1691685592;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pNJKNj8S/Xrr7Zv5tSl+mZVNrOUpmm1VQOeQBe887YY=;
 b=bBuUn69yXjaqSYUEDBT90Rcj2uX8eKyyXCv2igUFa0GEDvgCvvsJ8blT2kOG50kzeD
 LOMValWiFEUWOAgvxqKYw59H2qcxghJRwuaZvBF5FiuLHux0v3LOGP+qetorz0ils1Jy
 SgNQceYHdhkWA/Vl92j0MzjsX35w+HqYK/aE8Ayh/9cLWAL8Ggk4OLsmyqemlv5kcJhJ
 MerlJXkxb61u8YfIa1boYot9TrFQ57Y1AG7vFtddCZ4U12pVEdKTk3E3QVDseIqYYC4k
 jgEm4Z6ysWiSfgHl1TAEgOKtDA3/EKBqizdT7aIPY2ZCV5NwJDHtFiH8WdTyuLzdOuHn
 gCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691080792; x=1691685592;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNJKNj8S/Xrr7Zv5tSl+mZVNrOUpmm1VQOeQBe887YY=;
 b=MEvSvQnaQShiFnyLzpeAVKHYk79hujvE27fOUnXi4KC36FnX+LTKYttbKThXohONYm
 8B68hEFaHl5r7mTwuNyEYf41KMui0vJWj9HV/laqEh2+h8nBEPrJJ+O9YjSzz81yA/2R
 a8S78TtRYCN9k6cNWhzXk1niBjtcOvckZ2ZDFsaNKCR8ZipE+0PFu9R+byAkCSs1/fQd
 5qBnwSXPSLc2Htgu66Tl9q/Q/K0EpjfRbSlKqZ0L6kpaMuKfhtC2oKnWVgEf0cTkKWfw
 uk6qgTOnvI2P1oQNCQhhrnIf7uJOaC6ibZyRbUH4WQflChlbZ8Y8aROeujo4lugP5ZDA
 736g==
X-Gm-Message-State: ABy/qLa8TAeiMKK0Q4IHrCYbsyJiFSCet+ZId4MtbQW4tOI3AUEYQT7l
 SDR/CV5pYIXF492kcjwfICOHsG+NVgvL/8KJ6E71Dg==
X-Google-Smtp-Source: APBJJlGC+wHr53XhHChB+adEQWIYcLlDHefmfyNCGvxBTlAjxRvSwG88UKlgHg/0Z9COZ7fJDnOWeg==
X-Received: by 2002:adf:dec2:0:b0:317:5cf6:ab4e with SMTP id
 i2-20020adfdec2000000b003175cf6ab4emr7613138wrn.62.1691080791758; 
 Thu, 03 Aug 2023 09:39:51 -0700 (PDT)
Received: from meli.delivery (75.53-176-91.adsl-dyn.isp.belgacom.be.
 [91.176.53.75]) by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4204000000b0030ae499da59sm255314wrq.111.2023.08.03.09.39.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Aug 2023 09:39:51 -0700 (PDT)
Date: Thu, 03 Aug 2023 19:38:59 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Jonah Palmer <jonah.palmer@oracle.com>
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org, viresh.kumar@linaro.org,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH v3 2/3] qmp: update virtio feature maps,
 vhost-user-gpio introspection
User-Agent: meli 0.7.3
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803145500.2108691-3-jonah.palmer@oracle.com>
In-Reply-To: <20230803145500.2108691-3-jonah.palmer@oracle.com>
Message-ID: <ytqae.mub3s2ovpjom@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Thu, 03 Aug 2023 17:54, Jonah Palmer <jonah.palmer@oracle.com> wrote:
>Add new virtio transport feature to transport feature map:
> - VIRTIO_F_RING_RESET
>
>Add new vhost-user protocol feature to vhost-user protocol feature map
>and enumeration:
> - VHOST_USER_PROTOCOL_F_STATUS
>
>Add new virtio device features for several virtio devices to their
>respective feature mappings:
>
>virtio-blk:
> - VIRTIO_BLK_F_SECURE_ERASE
>
>virtio-net:
> - VIRTIO_NET_F_NOTF_COAL
> - VIRTIO_NET_F_GUEST_USO4
> - VIRTIO_NET_F_GUEST_USO6
> - VIRTIO_NET_F_HOST_USO
>
>virtio/vhost-user-gpio:
> - VIRTIO_GPIO_F_IRQ
> - VHOST_F_LOG_ALL
> - VHOST_USER_F_PROTOCOL_FEATURES
>
>Add support for introspection on vhost-user-gpio devices.
>
>Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

