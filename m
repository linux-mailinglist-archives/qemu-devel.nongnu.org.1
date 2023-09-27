Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B907B0240
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSBL-0005Xl-2x; Wed, 27 Sep 2023 06:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlSBJ-0005XO-CH
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlSBH-00074W-QT
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695812051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgAOIJyzKvfv3YKJ6zrhNVcKGbuBZc2NEh5X2NStHnc=;
 b=FqvjTR4VA5yob5zznse9qzRX85MA7swvbeL8JlJ3hA1EPR4UD/XhCklePPDw9aKDEgyDy1
 J3QjYZW7zwiOBEsL6vYy6cL2ITUVQ6kGvup/kiCt4JjTuqNrE/8BZxHwn50jAm++x2q5xP
 E2RZH8/5YZTvYR409H+ukGY4us8F9D0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-yBlHP0cYPRi-2UKxBvVtGg-1; Wed, 27 Sep 2023 06:54:09 -0400
X-MC-Unique: yBlHP0cYPRi-2UKxBvVtGg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31fd49d8f2aso8914935f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695812048; x=1696416848;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RgAOIJyzKvfv3YKJ6zrhNVcKGbuBZc2NEh5X2NStHnc=;
 b=W8lBj3k8EshO8u+1cNf1WGicbwFBL4z10HUM/u7TCUiB2/N8HHGhFc2OqzqFu6Y7hY
 tHz9NBz+3vcX2y0JZXCcjYVXzkUdqVzdnMUTAZk5z7yLByvW7Yh5V70cClVl8/WCakgK
 dPZhQ1jqbhn/9Xmd0TA2YJaWzgKmBbuUYnBpnfy2gxdHzyhZ6BNtQ8l9cbXrAwaoGmMQ
 isN6nJ+/kjo6lINTBSye15XqF+gbVrL5Yn1gPiw3Lg73Eq1Yyz/7105dbPilJ+zBnJqL
 Ar2l/RsX7Q/lBN9hn2AkynWemWPzGkxOZ0v73DRJp5mBtlBHND/EHwkmZzci/0/rMc34
 6Hwg==
X-Gm-Message-State: AOJu0Yx2LQJltsiwYhco1w4uz4tv2fYY9BZQ0sOACUMWlfGpMHoUtDGI
 TXZPUUALH5NhZGdlnzKYT0VAEGGw55Phju0DKtVCXnnq8KyPhoYAAQNWwz5+p7JmM3c3B7TmiRf
 XkXBnY1bbtArR/IQ=
X-Received: by 2002:adf:d1cf:0:b0:320:77f:a982 with SMTP id
 b15-20020adfd1cf000000b00320077fa982mr1664379wrd.45.1695812048458; 
 Wed, 27 Sep 2023 03:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqaMtQ3cQWPfmkfgEhMmH7e0okuBqQX4vyMvRoxD914zlrWoe8YU8bZ1UVC5A6wlh95ZyYVw==
X-Received: by 2002:adf:d1cf:0:b0:320:77f:a982 with SMTP id
 b15-20020adfd1cf000000b00320077fa982mr1664351wrd.45.1695812048071; 
 Wed, 27 Sep 2023 03:54:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:6900:3a06:bd5:2f7b:e6eb?
 (p200300cbc74969003a060bd52f7be6eb.dip0.t-ipconnect.de.
 [2003:cb:c749:6900:3a06:bd5:2f7b:e6eb])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a1c7701000000b003fe23b10fdfsm20271697wmi.36.2023.09.27.03.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:54:07 -0700 (PDT)
Message-ID: <0ae7ec95-fbd4-da08-dcbc-b89b6c41875b@redhat.com>
Date: Wed, 27 Sep 2023 12:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/7] Add Hyper-V Dynamic Memory Protocol definitions
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1693240836.git.maciej.szmigiero@oracle.com>
 <fe8d1cf3f51acc307f7a3ab33e93fac9020ff3bd.1693240836.git.maciej.szmigiero@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fe8d1cf3f51acc307f7a3ab33e93fac9020ff3bd.1693240836.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 28.08.23 18:48, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This commit adds Hyper-V Dynamic Memory Protocol definitions, taken
> from hv_balloon Linux kernel driver, adapted to the QEMU coding style and
> definitions.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


