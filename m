Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF527B72CC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:52:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmNA-0007xQ-2O; Tue, 03 Oct 2023 16:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmN8-0007xH-L8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmN6-0005ju-Em
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696366319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTBguMrw+l0SCBPX1UZno/n8JMNvi2wOzVzbS9MrMyE=;
 b=RdPdUQgfHdit2f0nqpmzHKCEYyKkt/yQRxJf9520hCjRBQSXZNz9VeM9BMUbszWqPxFQCI
 n5bsLaISkhqik370ZkNTdF1w0ZkTqjCllbGru05+wo3qQgSRfQncxF9h+x5BzqlX9v/bmO
 qaxuUEyznceMjfLD60QDXqXwmhXcZ1U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-rbMz0LXKMW-K8b49bPke8w-1; Tue, 03 Oct 2023 16:51:58 -0400
X-MC-Unique: rbMz0LXKMW-K8b49bPke8w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4197468d5caso4034381cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366317; x=1696971117;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTBguMrw+l0SCBPX1UZno/n8JMNvi2wOzVzbS9MrMyE=;
 b=iiCsiCyYs5AlE0BYpPvifKWEeNoN/Z/VqxS/7EXEA1hO37x+hApNqmky/85UuX1xhH
 pAMQeTLP85LzXaWcupsKVD2FfgCM4NBcwISbuwhhN/rN4MOh6P0P9GlId4wPc+17/dNb
 Gw6QE1F0UNlhNEHGh98iIubVqs5mWhBZop75204PErnNFfax+IzR86baWMlvWIWO+hjR
 tVf9S3dfNQcQ0rZk01k5WQteBUWPSqDjaeTziyQi0eqsZXCbCAWW5GbzqLNSlcirGqsE
 13B38nV6AlstI9rStWEK4aD0UhEQjS3khIB//UwZdP4vBP6vHJMtPLBrxXYPBh52pmTA
 mVOA==
X-Gm-Message-State: AOJu0YwDoACRdPDJmH271KYV2XeK9jT1e2dd2OhZKeAGhMxzqX7Cflhx
 X8bd4XoYjkX4go7qNB8eVMXPBOz+eY74pxzuoi7BsHtZ0wOKCZDcOOAfoOsBcavY0Fb6QyXXsc1
 0qDF+fdcFQlXg1gA=
X-Received: by 2002:a05:6214:3018:b0:668:deb6:1294 with SMTP id
 ke24-20020a056214301800b00668deb61294mr479171qvb.2.1696366317538; 
 Tue, 03 Oct 2023 13:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhgTTFWlNwYVTLv3NEeFEoyyX7PqCaDKPwhzP/lBXHwoML6q1XeeEjalBIjt+iKgDxIMNV2A==
X-Received: by 2002:a05:6214:3018:b0:668:deb6:1294 with SMTP id
 ke24-20020a056214301800b00668deb61294mr479158qvb.2.1696366317271; 
 Tue, 03 Oct 2023 13:51:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p17-20020a0ccb91000000b006585c7f64a3sm781974qvk.14.2023.10.03.13.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:51:57 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:51:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/5] hw/intc/apic: Rename x86_cpu_apic_create() ->
 x86_cpu_apic_new()
Message-ID: <ZRx+60h8XGwKskoD@x1n>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003082728.83496-5-philmd@linaro.org>
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

On Tue, Oct 03, 2023 at 10:27:27AM +0200, Philippe Mathieu-Daudé wrote:
> x86_cpu_apic_create()'s Error** parameter is unused, drop it.
> 
> While there is no convention, QDev methods are usually named
> with _new() / _realize() suffixes. Rename as appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


