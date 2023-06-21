Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5445738297
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwef-0002f6-6L; Wed, 21 Jun 2023 08:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBweZ-0002ec-JP
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBweW-00053q-Na
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687349374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kmZqkyDCD0mwk+ISNvKLX/ovfqtcz3dJm97viSjS0E=;
 b=ZU+CmoEzFuCxekXkYrQ5agv2MyBqT1yuZ5Py07TYnH7YfIB09fppWqrd3efR3YpBwrW8s6
 by9vBP9+od0BMPWsQ+qotG72pduAZgrgPJ6PITPbFHqtU8F6qeOQq2DOpZKgQuGYNUkiBL
 9VgCtoemnhkpwq4up69AqLDoiVOU0So=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-iBg6LfcDOjOGKdWwiHExAg-1; Wed, 21 Jun 2023 08:09:32 -0400
X-MC-Unique: iBg6LfcDOjOGKdWwiHExAg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so31409015e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349371; x=1689941371;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3kmZqkyDCD0mwk+ISNvKLX/ovfqtcz3dJm97viSjS0E=;
 b=IjH2+c/f63mqNvdhCmv0GX7eGF1jJtpczqVS1kyi9DT7q/WefB5rgUHGwuD+Up/KJ9
 yERtMR97O32Dv/U/7luGezI6z892rGg9WIJ+NVn+4j/Yavhrh4Mk/CDKkdW7j8SG7LCd
 CD7suSamOD8TDhrHdc36gKxHF2vKhpquGXxOQggo/1o48bBcSx75lM/CG27f1BUL73J+
 I+4/AKd5SFXsGJrrTbupPtD/brtJ2mIXPu5HN3irePDl8BUX0t0jVLc72m6HWEBUeyy+
 GnH4+Xf3LZ41QTg2Xtrx7Th2pFt/xMQvM43Zgfihh7uK8m4jIt+JV3iHwVALAW6UEb8p
 3UeQ==
X-Gm-Message-State: AC+VfDxLXBYPrBho0vjupwG6gHBZT6fGniydQrxS0lwPFPeuD5gyr5DH
 Llar2ouAMNrH+ARSRXikLx0e1MgXTo9ieZ/IPzkOnBy4HMzLvMhC/iyaoMWQlVFNqiXoWRnuyrA
 0X0oUDVKKX3SSV0M=
X-Received: by 2002:a7b:cb88:0:b0:3f9:b0ed:b729 with SMTP id
 m8-20020a7bcb88000000b003f9b0edb729mr7639151wmi.18.1687349370952; 
 Wed, 21 Jun 2023 05:09:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PXEyTiSAtO6nXnJoBSy5tciEjPjmOVEJDfKQlKPPqtgW0xMcTPrWSl4DAwx9zMlaCqhaPTQ==
X-Received: by 2002:a7b:cb88:0:b0:3f9:b0ed:b729 with SMTP id
 m8-20020a7bcb88000000b003f9b0edb729mr7639138wmi.18.1687349370605; 
 Wed, 21 Jun 2023 05:09:30 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f9bd9e3226sm1722801wmi.7.2023.06.21.05.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 05:09:30 -0700 (PDT)
Message-ID: <806a45bd-c74b-409f-521e-d6d1dbb1a8a6@redhat.com>
Date: Wed, 21 Jun 2023 14:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/21] tests: make dbus-display-test work on win32
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
 <20230606115658.677673-8-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230606115658.677673-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06/06/2023 13.56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/dbus-display-test.c | 43 ++++++++++++++++++++++++++++++---
>   tests/qtest/meson.build         |  2 +-
>   2 files changed, 41 insertions(+), 4 deletions(-)


Acked-by: Thomas Huth <thuth@redhat.com>


