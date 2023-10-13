Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663517C7FDB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD2a-0002AE-Ur; Fri, 13 Oct 2023 03:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qrD2C-0001uY-B5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qrD2A-0006St-ON
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697183793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UE9H6AugzjByUvbh4gamA3MGsEmHDEpn0IzlysigyfE=;
 b=PHvjyysQRvHQ0pzjKZ5iN0VCGHg2kUu5gJ0UeaheghtaVpsSIR+eZa+tFzpnjry+Z5to6T
 ipA+KhfmFoD6A7tgNEogxRhm6gX1fbpiaROLlMRQ88zhIbvmR7rx4qxs5FXG9vKzclYnO8
 17arwrtcZ5wVQGMDYdYdyetm4wvQtPE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-2yHrF2ZrOjS9wYNAcZpWww-1; Fri, 13 Oct 2023 03:56:31 -0400
X-MC-Unique: 2yHrF2ZrOjS9wYNAcZpWww-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso123974566b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183791; x=1697788591;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UE9H6AugzjByUvbh4gamA3MGsEmHDEpn0IzlysigyfE=;
 b=N4FUj/JJh9Fr+xScj0XrCj6KHxon8UlcCWwfDOb6Wzf2l+qScEeNmj9RxmHPOvbJZp
 dLePvGp+yjijNPRqDKXvuzOJ2IdHPtyVQkU1+WZX5tN5FdYc+3ZjX84xmK7rmpx68Wfl
 x3iZIRc/a3b5Ulkog0Oc+Jbx2DT7mvO6wdwugjIII6gwxy0Gh6+DS2+4oEOFloTK0Wt/
 7iRa/cAHCATvIYW2UkNmPOJWIPhryQ5TM6p1oKeScOlRbGQeWsAu3LZ+NB6oAMyH/yTH
 Zl03MGXqjj4AgcwixrT81y5ShoZynJ/1MwvA5YkwOTfxgWggfiQrmtkpmEwc0eGgMPV+
 0duA==
X-Gm-Message-State: AOJu0YzlB8LuiCGwd/4+PxEaC+BCbVjIIRPhlfTvphlNYHnUh7+zVVQT
 bwAu50JVq53odCI32ej0pPR9NRpdrFpFdXICjTlX/YA7M8UTINF+7Q23O3iC+EUTtc4Po30yY+t
 mh4S13PaDxJcwDUtCFfw35KM=
X-Received: by 2002:a17:906:76d1:b0:9b6:8155:cbef with SMTP id
 q17-20020a17090676d100b009b68155cbefmr23897622ejn.61.1697183790726; 
 Fri, 13 Oct 2023 00:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZEkAJB3YBgQsHW9rv1+RpFaGKjxAbgcq7/VmPVikYmtyxbmHEppNhO5jfADRn172E+svfCQ==
X-Received: by 2002:a17:906:76d1:b0:9b6:8155:cbef with SMTP id
 q17-20020a17090676d100b009b68155cbefmr23897602ejn.61.1697183790273; 
 Fri, 13 Oct 2023 00:56:30 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6028.dip0.t-ipconnect.de. [91.12.96.40])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b00989828a42e8sm12017225eja.154.2023.10.13.00.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 00:56:29 -0700 (PDT)
Message-ID: <2674ff6d-8b6b-dbd7-9d00-0b6b0aa4b8d6@redhat.com>
Date: Fri, 13 Oct 2023 09:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 07/78] hw/virtio/virtio-balloon.c: add fallthrough
 pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <40e39148a03476f886d37500e4104fad64107d63.1697183082.git.manos.pitsidianakis@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <40e39148a03476f886d37500e4104fad64107d63.1697183082.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13.10.23 09:47, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


