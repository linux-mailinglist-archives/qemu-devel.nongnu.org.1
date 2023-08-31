Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B393F78E87C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdDV-0000RY-2T; Thu, 31 Aug 2023 04:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbdDT-0000RQ-M4
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbdDR-0002Vy-Bd
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693471187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mWoX6dA3SBhDj+3ryEghGVTq6HXU3X0NCEY/VZUD4w=;
 b=N6xNHBTbivK5Z1JMUT9L/Fkd7Do82e4tiTlOK3gKAaKvnB80Ex5uG/7227jN8DmlOwpGXx
 S4+Dd9eKkkHbzXEch16SDXcBCKURWdh+AcHi5KZpGb7LXNga+ExOV0o1n7LO1qi70BN2Q8
 lKVq6MvIrSrGivpgj1qXf5QOyBu8y50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ogK1H9QIMIi2A4qZOCgKhA-1; Thu, 31 Aug 2023 04:39:46 -0400
X-MC-Unique: ogK1H9QIMIi2A4qZOCgKhA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-315af0252c2so291814f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693471185; x=1694075985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0mWoX6dA3SBhDj+3ryEghGVTq6HXU3X0NCEY/VZUD4w=;
 b=YK67eAs19LDM0P9MQGhKFkQDehyFyCLRJSvvEJEO0/F3EYWiyBXwUZbvwlxbgngV8k
 5ht6lVxkbOTlxJcD1eVndmGgSjVkcbLeIvNI3nbo53Uon4839IVUCTdMzUpaGtsnQp+Q
 xA52ghjFXmqDIoZZ7EPQQeitk/cbxaozrxcpCLzHFcbW09YwPAnKOlB2V2M9IgUUQS1E
 2elUw0QdU4jde3ALcYFQs+37TgATtfRbZVWBDBCL1UxDh13m+j7prvZat5Z7lf7HyXRi
 +jUlDg+lpsxzmP5EomIUxstfQ0wZrsSmP/Q31QvSp7E5Iztfgm+cF4pj+e2V7ArdxUEW
 e+5Q==
X-Gm-Message-State: AOJu0Yz0iJr/+CngXRz/y98vKbKaYU6H336QMQFH7ieThTIXJ3fU+zIA
 8OgRT5ZNyfHbZ78tZqmIcg2bmkID58dCMI8gPKqvJx3Eov45e9ILRQ4VOh/zN0PpQEfQ1a8uXnl
 316KkLaib499rNwY=
X-Received: by 2002:a5d:4588:0:b0:318:8ad:f9f with SMTP id
 p8-20020a5d4588000000b0031808ad0f9fmr3297053wrq.24.1693471185119; 
 Thu, 31 Aug 2023 01:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGftv6Ny1k5melAVzSouUZdAtfDC0ZMXfJv8/45BX3y+NtXRXII1M4x3ZGhNL7B6Y6aFuyuQQ==
X-Received: by 2002:a5d:4588:0:b0:318:8ad:f9f with SMTP id
 p8-20020a5d4588000000b0031808ad0f9fmr3297034wrq.24.1693471184792; 
 Thu, 31 Aug 2023 01:39:44 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-223.web.vodafone.de.
 [109.43.179.223]) by smtp.gmail.com with ESMTPSA id
 h17-20020adff191000000b003180fdf5589sm1429037wro.6.2023.08.31.01.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:39:44 -0700 (PDT)
Message-ID: <bb3a12e2-dd2b-091b-ccab-bec14fcbce50@redhat.com>
Date: Thu, 31 Aug 2023 10:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] accel: Remove HAX accelerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230831082016.60885-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230831082016.60885-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 31/08/2023 10.20, Philippe Mathieu-Daudé wrote:
> HAX is deprecated since commits 73741fda6c ("MAINTAINERS: Abort
> HAXM maintenance") and 90c167a1da ("docs/about/deprecated: Mark
> HAXM in QEMU as deprecated"), released in v8.0.0.
> 
> Per the latest HAXM release (v7.8 [*]), the latest QEMU supported
> is v7.2:
> 
>    Note: Up to this release, HAXM supports QEMU from 2.9.0 to 7.2.0.
> 
> The next commit (https://github.com/intel/haxm/commit/da1b8ec072)
> added:
> 
>    HAXM v7.8.0 is our last release and we will not accept
>    pull requests or respond to issues after this.
> 
> It became very hard to build and test HAXM. Its previous
> maintainers made it clear they won't help.  It doesn't seem to be
> a very good use of QEMU maintainers to spend their time in a dead
> project. Save our time by removing this orphan zombie code.
> 
> [*] https://github.com/intel/haxm/releases/tag/v7.8.0
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I plan to commit this in my next PR.

Yes, please!

Reviewed-by: Thomas Huth <thuth@redhat.com>



