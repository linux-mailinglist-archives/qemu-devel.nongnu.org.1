Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396C748221
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzkH-0002yT-1p; Wed, 05 Jul 2023 06:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzkF-0002xr-54
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzkD-0001oc-13
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688552900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEB+aof1Pzf49zNIo1enqXQbg6MUhDXyvCon83N6zzE=;
 b=i+xcNOIoB0oXPEH9tPzcMXqt5FEfki3D1O/rRhgaNXC2vqsA8Wcd7LOEYZ9bzIiuilGwiC
 cFuVNd1TMRrW/GjoNG7LV+bx1JhDzSn+N3hBUPG0xF2S7IcjrUrNxRF0aQQL+rKG82QaZx
 XMU0J4CCCAVyrohJZUa29rpUwNflHvc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-0ZfCHfOvO5Wrzapk0UQnhw-1; Wed, 05 Jul 2023 06:28:18 -0400
X-MC-Unique: 0ZfCHfOvO5Wrzapk0UQnhw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-621257e86daso70416346d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688552898; x=1691144898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FEB+aof1Pzf49zNIo1enqXQbg6MUhDXyvCon83N6zzE=;
 b=IfqIjOKl3v2ptdO9unlEvgvgZPQat3L7rB+6yKouQhb3T7FXFU3ndrgm6rzjWTvJWO
 Ji/N1hZ4baQOOt9xTg9+WRnCMHnOUIe3CPuMW4PVIzVHZ4gwTxkhEI/ThYew0QEuY90R
 VR+vdOnTRmvJz0mnrSdkpVMWlRraZ6b02bXYezf+TO+Ig/CmTPzaR9hdPJDUZ1pkvUoz
 g4mQBtCOfGNfEeuYj4BtOWw4pT40w0nF7d5/lMspHHpyEfG7wRZ5f9XmsXZ+faozSDCn
 +1wdIaNH+Qw32TDakMfWaHW2OOVEtF7CkisUtNJnmp4Q6rFDrQjTu3jmhXCADS0QOlFY
 4QDw==
X-Gm-Message-State: ABy/qLb+yH/IJA+z+yWl6d5G22iSJ+8xveDf+hBXfRudrqMSWWyYrHHi
 f1I6VQbBeOygx7ykoNqASSUmlRiv2C3oVQtWwohmd8wFrFW2m7toMkdCGP06SIJAHYCkjLYyfGl
 u1bW5MB+BZmq0zbE+Oqv+Irg=
X-Received: by 2002:a05:6214:5296:b0:635:f23e:ef9a with SMTP id
 kj22-20020a056214529600b00635f23eef9amr17763008qvb.7.1688552898422; 
 Wed, 05 Jul 2023 03:28:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHS/LvQu4/QXgnprYiEKj+0NdMXjNouAnzlWe4GVO4oKGSwod0uWyRnWxNAwAxfUPvuvaKoxA==
X-Received: by 2002:a05:6214:5296:b0:635:f23e:ef9a with SMTP id
 kj22-20020a056214529600b00635f23eef9amr17762978qvb.7.1688552898207; 
 Wed, 05 Jul 2023 03:28:18 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a0cf80f000000b006362aac00a2sm7100753qvn.29.2023.07.05.03.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:28:17 -0700 (PDT)
Message-ID: <a6315330-b17c-b0fa-ed99-44ed36d47946@redhat.com>
Date: Wed, 5 Jul 2023 12:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 19/20] tests/avocado: s390x cpu topology dedicated
 errors
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-20-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-20-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/06/2023 11.17, Pierre Morel wrote:
> Let's test that QEMU refuses to setup a dedicated CPU with
> low or medium entitlement.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 48 ++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


