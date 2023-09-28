Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F27B1E64
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:30:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlr5k-0008ON-1T; Thu, 28 Sep 2023 09:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlr5e-0008O8-CU
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:30:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlr5c-0001vn-OA
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hL6z7J5uTOdKZypI7o5KpHZHx7aXQPatW9aqxjUE4Vw=;
 b=Xs2yqx4YqE8fxIT/HakMI2kiFAaeyhXqaJSPfKbP/YazUfbE7xvwKzL0eNUCjo/wHORBJk
 U//VGynzTv4qtuyMmNgiVRqgIYUAgtb/in756NXXxD4JwcgSpPxbK2AIQcN07y3xMUCeGt
 DyahrAFluU1EhBpgZ7qPRENkjs6Q14I=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-hykAcqMAN3CMUHkPcNMvzQ-1; Thu, 28 Sep 2023 09:29:58 -0400
X-MC-Unique: hykAcqMAN3CMUHkPcNMvzQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7b0775207c7so148944241.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 06:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695907798; x=1696512598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hL6z7J5uTOdKZypI7o5KpHZHx7aXQPatW9aqxjUE4Vw=;
 b=CnupJPV+4UU7GXV/wrQyGR294lYjSa9RrAHYIzZP6uUHOyoZtkCvBaslAVTCQ4uSjZ
 nmol7dWcp7lDBAriAj4CAbeqOkl3P6VsvxXMd4jRK1kZqO35hlksZfxbgaVydAWyO8AO
 DLstBYpJbYnMioReGs5Ix+RwNv+xtvrzAjyY1tMOl+uxFJ2U3jTGlzkOeud5tlkF1WRF
 nYAnRY1vcRT7XZGKoxkik2N2KVjRFK84wmIamCwTTt/2wj854aSo3fT8TH188yhDp76P
 a3ev1BgqRusuCTjlr8Szj/jT24u2OpAjrR7HeUiPHeVvu3X/84Xzc7ZyHvMrLC/2SwZF
 uEtw==
X-Gm-Message-State: AOJu0Yyy8YEH9SeLY69jUIw5mpj5dDNwd3DCCgoLqEm5QmglQLwzNPZM
 jywITdNcvnU0YF9TuqYINxPcDQXN++JFDVOlA9kcQQRRfkgt9c7kw7BY8Cjox5GmRJgsWE2DoDP
 t7pYEhNkp4TjpyPA=
X-Received: by 2002:a67:bd0c:0:b0:44d:4a41:893f with SMTP id
 y12-20020a67bd0c000000b0044d4a41893fmr1005865vsq.9.1695907797795; 
 Thu, 28 Sep 2023 06:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcQyCs6ajvT0zta5b5EBPnmT5YzQMVgVcz9A41DqnYgqDk2ZEJdZnp8CfCeVUwvrBbGv0aMw==
X-Received: by 2002:a67:bd0c:0:b0:44d:4a41:893f with SMTP id
 y12-20020a67bd0c000000b0044d4a41893fmr1005841vsq.9.1695907797440; 
 Thu, 28 Sep 2023 06:29:57 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 z19-20020a0cda93000000b0065d0d0c752csm468811qvj.116.2023.09.28.06.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 06:29:57 -0700 (PDT)
Message-ID: <7dc35095-f6ac-4a67-5fba-0aef2450cf38@redhat.com>
Date: Thu, 28 Sep 2023 15:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v24 09/21] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-10-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230926121534.406035-10-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 26/09/2023 14.15, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> The modification of the CPU attributes are done through a monitor
> command.
> 
> It allows to move the core inside the topology tree to optimize
> the cache usage in the case the host's hypervisor previously
> moved the CPU.
> 
> The same command allows to modify the CPU attributes modifiers
> like polarization entitlement and the dedicated attribute to notify
> the guest if the host admin modified scheduling or dedication of a vCPU.
> 
> With this knowledge the guest has the possibility to optimize the
> usage of the vCPUs.
> 
> The command has a feature unstable for the moment.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
...
> +
> +void qmp_set_cpu_topology(uint16_t core,
> +                         bool has_socket, uint16_t socket,
> +                         bool has_book, uint16_t book,
> +                         bool has_drawer, uint16_t drawer,
> +                         bool has_entitlement, CpuS390Entitlement entitlement,
> +                         bool has_dedicated, bool dedicated,
> +                         Error **errp)

Nit: Indentation seems to be off by 1 space in the above lines.

  Thomas


> +{
> +    if (!s390_has_topology()) {
> +        error_setg(errp, "This machine doesn't support topology");
> +        return;
> +    }
> +
> +    s390_change_topology(core, has_socket, socket, has_book, book,
> +                         has_drawer, drawer, has_entitlement, entitlement,
> +                         has_dedicated, dedicated, errp);
> +}


