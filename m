Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45F786152
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuMb-0005CG-4T; Wed, 23 Aug 2023 16:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMX-000533-MH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMW-0005DN-Ah
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692822115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZUUI9OuJikA+Ni22WO2mMugGOnErdZK+bc8iYyX1q8=;
 b=CQYF/ze+h+FxgwtLwUDAqFfRGwllOXws9VFO+7z3v3/6h/jzXTtVZuOxyOhXcQo2pwTszh
 yH2rtI5K6hMl85iOSbFot9jGCC+B2dVRrjOvC9ARmHr5EQ4gIrdFw6gYOyHj5JNQPQ83GT
 kwLQMb5FWIWPG5DvNXPTTpkGdmRs/Yw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-JVoWyNO1MJyu-Eym1J5zWw-1; Wed, 23 Aug 2023 16:21:54 -0400
X-MC-Unique: JVoWyNO1MJyu-Eym1J5zWw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-64d08acfd16so13465776d6.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822114; x=1693426914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZUUI9OuJikA+Ni22WO2mMugGOnErdZK+bc8iYyX1q8=;
 b=Q79kInLKBYetEPjPUzUwPBraSil4JbwesClfArcgGwwVLgz9u3f+x6ycq9V6GyvmkN
 rgJjo9/51jhoo3Ba1liBmLo4FuDPJcu/OXOSskqTfDNKb+rL99OYYXdiuEL45YEDKZ0i
 EcVzwAJsdtcs2+RNQ89mFH8zyy4D8JRiu4H5KlyDF0lhM1fihiKL8UisstcXSKWN+Vte
 g4HKZk/xG2phaEsCBpkaJDDQ/as/t/J3bD0wpENFWanz5hcL7vGzp5ee0wrvrKudQDTa
 AFa/xlpPShb025Bqmog5kESMPokbKXm5YSPM/rldKUbysFN0U497u+BW++xL/TKOQxfn
 JsEQ==
X-Gm-Message-State: AOJu0Yzm8KN2MLzKJDQ6dzTkMVibJvYrX0DJeB3fbC/NPXbTU+7IXM3J
 QXd5C5MVC9bmIbcmLQkOdwKpqB3GpbtbYoAl1efC7YnqyBWpsLlgiiWwjHTWec/OPs+yBD9VxEz
 ZOZEjDESqYPYazHg=
X-Received: by 2002:a05:6214:4017:b0:63f:64ba:a30a with SMTP id
 kd23-20020a056214401700b0063f64baa30amr15536031qvb.2.1692822113934; 
 Wed, 23 Aug 2023 13:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8tgUv1dSbyVgcYuz3MY3iOcRnWWac0uRH3hlmAzO/Hv1FLcinM/Z8dRB+ea4w/A0VAo5LnQ==
X-Received: by 2002:a05:6214:4017:b0:63f:64ba:a30a with SMTP id
 kd23-20020a056214401700b0063f64baa30amr15536015qvb.2.1692822113721; 
 Wed, 23 Aug 2023 13:21:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u16-20020a0cb410000000b0063d588c4111sm4849964qve.82.2023.08.23.13.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:21:53 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:21:51 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 05/11] softmmu/physmem: Bail out early in
 ram_block_discard_range() with readonly files
Message-ID: <ZOZqXwDAMZ3XICOQ@x1n>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823153412.832081-6-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 23, 2023 at 05:34:05PM +0200, David Hildenbrand wrote:
> fallocate() will fail, let's print a nicer error message.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


