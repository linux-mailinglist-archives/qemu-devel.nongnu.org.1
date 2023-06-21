Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA341738298
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwfp-0002zq-Be; Wed, 21 Jun 2023 08:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBwfl-0002zW-Rx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBwfk-0005U8-D7
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687349451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4HXLXYApWVsqU7SVQ+EXmT7D+F7hOQPlJ1LAyOGeCM=;
 b=LEDx+IdMNcjBm6hMtC8i1cuduC6Udg1wzRMK7ri3fSEm4D19yIgr4hT9SMaIBSHzg21jh5
 GsbNTKD7+YyQcsVLjLJHjcG5vfJxe64FQbHb/okIwi8OLoxSoZOyO40pfIpPQTCxi8pLmg
 Hm8EMav2C/YKvVZ6cMScGzEzs0Av/AM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-p2sPPVtjMpWJBTk1tPs3Qg-1; Wed, 21 Jun 2023 08:10:46 -0400
X-MC-Unique: p2sPPVtjMpWJBTk1tPs3Qg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31275d62506so1169749f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349445; x=1689941445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4HXLXYApWVsqU7SVQ+EXmT7D+F7hOQPlJ1LAyOGeCM=;
 b=RauChtrdKusNiuSJ3I85SEuUrmda1dR6glUqIejsFSQ+yX4NN4uTOzx1NL+DYHJX2d
 //fh9h1NA14etcoxOHhI2ss5gRc2DGeelAHXyoLwi8B0II5ltI++hxozGw3Xuex8wg5+
 YmHSbnkXaTcffeB4rD6tvlyYIXPbucgK0yKU8Nmi5UW8C1wXtD0OzadedHA5kzIMzBUj
 CkL3f8qIoYzOUhyesPHt/IntYBtoBxHqwTsi5eOehkJ6ZrkkCTXwBYalQG/NeXcuhbRf
 VHX/krirtNbJ/3vDaH17s2g1XM5lcmA1i1UzX5r5aXs6fnZE18yxuAIuwB2ceQ+AOpEk
 6OJA==
X-Gm-Message-State: AC+VfDwj7thQE4TvG8ewMwl7EsQZY9W3N67pnpMozJzPuEIYC6Oiyh/2
 U7nCn43oV3o9I74tTkVO24gWXmEt03YDzc6M1slwR4Uen3AShIWI4lN23viktP7AkoCukZQSfeY
 xm6XsbYxh0d+3lEI=
X-Received: by 2002:adf:f6ca:0:b0:30e:438f:8ceb with SMTP id
 y10-20020adff6ca000000b0030e438f8cebmr9404504wrp.59.1687349445333; 
 Wed, 21 Jun 2023 05:10:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LZFRuxNOujo0wpX5iJ4dEo8RVNEzKgFIMyVHe7rHgXFMytzUu7bclQWkxh3lMVyMjcIVzeA==
X-Received: by 2002:adf:f6ca:0:b0:30e:438f:8ceb with SMTP id
 y10-20020adff6ca000000b0030e438f8cebmr9404489wrp.59.1687349445060; 
 Wed, 21 Jun 2023 05:10:45 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a5d4fc9000000b0031134bcdacdsm4304815wrw.42.2023.06.21.05.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 05:10:44 -0700 (PDT)
Message-ID: <ae42c0a8-7c35-6c60-29ef-78cfa02b98d1@redhat.com>
Date: Wed, 21 Jun 2023 14:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/21] qtest: add qtest_pid()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
 <20230606115658.677673-7-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230606115658.677673-7-marcandre.lureau@redhat.com>
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
> Used in the following test on win32, to share sockets with the QEMU
> process.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/libqtest.h | 9 +++++++++
>   tests/qtest/libqtest.c | 5 +++++
>   2 files changed, 14 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


