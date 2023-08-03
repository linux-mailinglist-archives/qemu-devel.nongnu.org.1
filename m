Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5476EF93
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRbHL-00073u-6S; Thu, 03 Aug 2023 12:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qRbHJ-00073d-L8
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:34:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qRbHI-0005ig-4K
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:34:21 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so1091434f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691080458; x=1691685258;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OrJ6TQSeD7pJmQ3ZkasHR+d6aa5x8sVjbluCB6q7jks=;
 b=Olf2XJmmj+HORg+DeZm5YTUCpFkcy8NSl80WGAl7O6AgK5zpk1no+QTdfMuD5X6KgB
 d5Q32Y/OAVYpjSm2Me+Wv/xgMAx6a1Q9BYx+OL/ypYTzNdnqbw/8TxooaUsUhcuJjLZC
 7jxinG5/2HhVvQYBZ2ksp7fHWY3vlr19ByDeGAWpcjqH6euEUMAJoIIWXDd5Q4rblsX5
 KC1OrxdIYUkTuT6QdnpngO2qUgm0//O0ks9mk9X3HtAQFL4jguUEm0aBhWFstR+iRv/A
 RI+YMqtiLM+krP9HELgKLXerWt6RIjfaLVhYU8buQDaa3wX0y3e2nCJibWA2hm9khXSI
 XRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691080458; x=1691685258;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OrJ6TQSeD7pJmQ3ZkasHR+d6aa5x8sVjbluCB6q7jks=;
 b=I7Xibk791oRoCKayk+KiyjQpeuLePS04fpD06KM6N1UyalTZ/FDwXeFSHfanVUIEFx
 j0NQG/Hb+Q9wIQRvZIQTg/4v1x806+n8uVKPltCW/AuV00c4oMmFE99QY4ajTKZMcWHx
 1ZdIYZihIvNr20/JTYmMWh66nzhaMJGWKTF94s+F0zZXBZZPpARiY0imJ9lRlST+LARK
 tWkuRed5xYaPdMiB3uBdJjIL9egXUh20/Vm1cmcpCjxM1kD/rFl3Dckz8dRkLOTXgj6R
 MW+zQdRj60sVFOKMvX/P+Gm+cnnnbKOFxbC+1doWjU0A8nnNWtM0gyhLutlzzeHqiWQe
 KMDQ==
X-Gm-Message-State: ABy/qLa1HWWtTpbJDfY5TwytKGbHe/YSPdLRdI7v8DegsDFhD6Tfn7mf
 3aF2ZM9IDII8L2auiD6dAvHxm4g/MBQ8fu55rHAeDw==
X-Google-Smtp-Source: APBJJlHhlgKtRSR0g7MVlD3jJp3ppLCxROhTWqGdaNe+RXYk89sBMsOuFgBGdxJ6QWNYme6Yfv2feQ==
X-Received: by 2002:a5d:4e0a:0:b0:317:5747:b955 with SMTP id
 p10-20020a5d4e0a000000b003175747b955mr8100565wrt.17.1691080457865; 
 Thu, 03 Aug 2023 09:34:17 -0700 (PDT)
Received: from meli.delivery (75.53-176-91.adsl-dyn.isp.belgacom.be.
 [91.176.53.75]) by smtp.gmail.com with ESMTPSA id
 r15-20020adff70f000000b0031763fd36c4sm250498wrp.104.2023.08.03.09.34.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Aug 2023 09:34:17 -0700 (PDT)
Date: Thu, 03 Aug 2023 19:32:19 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Jonah Palmer <jonah.palmer@oracle.com>
Cc: philmd@linaro.org, laurent@vivier.eu, mst@redhat.com,
 boris.ostrovsky@oracle.com, alex.bennee@linaro.org, viresh.kumar@linaro.org,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH v3 3/3] vhost-user: move VhostUserProtocolFeature
 definition to header file
User-Agent: meli 0.7.3
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803145500.2108691-4-jonah.palmer@oracle.com>
In-Reply-To: <20230803145500.2108691-4-jonah.palmer@oracle.com>
Message-ID: <ytq14.zkqygy78kdyo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

On Thu, 03 Aug 2023 17:55, Jonah Palmer <jonah.palmer@oracle.com> wrote:
>Move the definition of VhostUserProtocolFeature to
>include/hw/virtio/vhost-user.h.
>
>Remove previous definitions in hw/scsi/vhost-user-scsi.c,
>hw/virtio/vhost-user.c, and hw/virtio/virtio-qmp.c.
>
>Previously there were 3 separate definitions of this over 3 different
>files. Now only 1 definition of this will be present for these 3 files.
>
>Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

