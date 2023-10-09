Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBA77BD6F7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:27:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmXf-0001M5-Vt; Mon, 09 Oct 2023 05:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpmXa-0001Li-Ax
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpmXY-00024F-U5
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696843623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uk95enCr2mCFVnW8WldzPpum1NUxrYd8HKxqi/ftfJk=;
 b=UcAoDFFJ8QhmvNRxv5EYoycKEorUeehByBN4m7lBqU/oT/cZfCPGg4O/Fh5BYzgZQbKaWc
 MqivSI3qdBHpYWn/F3TF6JHpLVaJNom4mEzSE2K6PYJtiy2eAZkTcg26CQ1KuVZLTxtKi9
 daQjipu+9Vp1/nDR52Jh6tBVvgS1+Oo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-_a8uzJ0PM_-EpDedt1gYBg-1; Mon, 09 Oct 2023 05:27:02 -0400
X-MC-Unique: _a8uzJ0PM_-EpDedt1gYBg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so3037932f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843621; x=1697448421;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uk95enCr2mCFVnW8WldzPpum1NUxrYd8HKxqi/ftfJk=;
 b=f1KJ8OOHqWBST+dQqWnnfp46dOBDVCtbri/9lxpM4EIP/ok9knZPnNYr7bPSmNFHHf
 sFrlO3XfMZr4RkuYZobuiXazR3qouP36l0flXFOMnRHQBtBHSzp/4lyBSro0znaDdkZQ
 eqpFXNQcXe5KfOn2G+DoC/U8Ycw512A3ysvBLsisBUclfT3jH7ypQYUihuRgkDNIlDFf
 uzdXRe+QbhvuJwm61nWmA2v6TpXIdlSuSGX4YY6oAhdXLmua+kez87cSoC31ul8S1Bvn
 zGYg7iZAmw6YFsqgOFoe0kjv9C1vDZHrVM20Y5c3Lamw4x6UuaWI0DS7QVNHCxvVe8Fl
 gHcQ==
X-Gm-Message-State: AOJu0YwYI/dW8le5n5TJTeH8DkE6mu2cvLNUUWnfQ9SJ9w0dhZcMsIqb
 wQM0LvphgX4uOUHm+GqbDPxidbUcqUIlwR54+mps2rh6rfDj8Uc/nhyAyi3uCDpRiIRobQY6Oh4
 6bOwYIrvheL0jkt8=
X-Received: by 2002:a05:6000:14e:b0:320:a19:7f87 with SMTP id
 r14-20020a056000014e00b003200a197f87mr12931506wrx.18.1696843620823; 
 Mon, 09 Oct 2023 02:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs/Qx49nYb7VrynY5pNwBEtTWoM2K8vNCeTj58mB2R1BtMn5JqOaIChjZlHM3oUjoDueYaBQ==
X-Received: by 2002:a05:6000:14e:b0:320:a19:7f87 with SMTP id
 r14-20020a056000014e00b003200a197f87mr12931495wrx.18.1696843620495; 
 Mon, 09 Oct 2023 02:27:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a5d424b000000b003248a490e3asm9095778wrr.39.2023.10.09.02.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:27:00 -0700 (PDT)
Message-ID: <e7f4c8a2-5780-79de-af3b-75ea8c155ec7@redhat.com>
Date: Mon, 9 Oct 2023 11:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] memory: drop needless argument
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231009075231.150568-1-marcandre.lureau@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009075231.150568-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 09.10.23 09:52, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The argument is unused since commit bdc44640c ("cpu: Use QTAILQ for CPU list").
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


