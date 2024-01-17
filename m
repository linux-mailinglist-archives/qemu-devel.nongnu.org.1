Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8988304A5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:40:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ4Gg-0005iS-6J; Wed, 17 Jan 2024 06:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rQ4Ge-0005i8-6n
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rQ4Gc-0006Gn-OC
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705491574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CH626pSqKFSD+Kp2qukzp0Y/x3O//9WPmqfkQBgYC4E=;
 b=SboU8lHm9OGcshuctTOwIRkwebtc1AS0M7OLBoq0jCDNrI8ApuiT9V8b4BSDe20ssQGX15
 Buhq1Kr4trF5cHA53s5SeufI818uYItS/ZD8QqB6ZWUUKHgClldvhWUrgupV6ML+iWLHSN
 8ZOc99FCsj2o/BktHXYZ1i7zcXvUHvU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-2F4_c1uGPi6o5IcXucWcjQ-1; Wed, 17 Jan 2024 06:39:27 -0500
X-MC-Unique: 2F4_c1uGPi6o5IcXucWcjQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-681803c692fso4728386d6.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 03:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705491566; x=1706096366;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CH626pSqKFSD+Kp2qukzp0Y/x3O//9WPmqfkQBgYC4E=;
 b=rhnP5agDmKlqs3eBdEmfDPnYQrEjUjPJxb0Ju8HDyPcFGwg8cC4Qc3cWHsCs9VvuYA
 5MdVGpmwaYT7ymEOBA2AzABRpijsAgcleHEbpklWtiW/f/fgyAZJrIuBS5cIt2P9KpwS
 x6O/5SzwLID99J5rHVUw39GzPdxtCO+TolK+pTUth/VRjXjUhY/8dTbDq7QUNhlpNpoc
 MJpp8q6iBgZx8FguQkuquEDEwn9BcU8IaqGQnk32Qr4XaF1rzM/CkUZFrElbuLyQ9Vrc
 L4ADu5ILytwysDEX5m80jycg6nKL2r++NM30w/lLNFeoMMLt6xawuUdoSiQlwfLw0U4b
 amNA==
X-Gm-Message-State: AOJu0Yy0W/Kiw+dgIp+f1bjqX83l08UH3HK8sgAAa5CvQf2bhQ8cp4lt
 6P0tqkyEc8axBQr1WG2dG138xcdzdKSD9g/uEoe2CcnIaWhzu7lpQ6+RcPIL3Reakly6t38Enn0
 +IxhnhFxmnAsgMS1q4RkvHJs=
X-Received: by 2002:a05:622a:1045:b0:429:7536:60a with SMTP id
 f5-20020a05622a104500b004297536060amr11218310qte.9.1705491566765; 
 Wed, 17 Jan 2024 03:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjyYd7TVFZ9RUZ/mmwqBFGqktSN/tkqg9ofBVdteqCohddRy4jWXtee54vCY5ApDEycDKOJQ==
X-Received: by 2002:a05:622a:1045:b0:429:7536:60a with SMTP id
 f5-20020a05622a104500b004297536060amr11218298qte.9.1705491566541; 
 Wed, 17 Jan 2024 03:39:26 -0800 (PST)
Received: from rh (p200300c93f0273004f0fe90936098834.dip0.t-ipconnect.de.
 [2003:c9:3f02:7300:4f0f:e909:3609:8834])
 by smtp.gmail.com with ESMTPSA id
 h7-20020ac87767000000b004260b65b4f7sm5677357qtu.97.2024.01.17.03.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 03:39:26 -0800 (PST)
Date: Wed, 17 Jan 2024 12:39:21 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>, 
 Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 kvm@vger.kernel.org
Subject: Re: [PATCH v5] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <20240115080144.44944-1-shahuang@redhat.com>
Message-ID: <71625f0a-da2d-92aa-0055-72140257b665@redhat.com>
References: <20240115080144.44944-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 15 Jan 2024, Shaoqin Huang wrote:
> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
> which PMU events are provided to the guest. Add a new option
> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
> Without the filter, all PMU events are exposed from host to guest by
> default. The usage of the new sub-option can be found from the updated
> document (docs/system/arm/cpu-features.rst).
>
> Here is an example shows how to use the PMU Event Filtering, when
> we launch a guest by use kvm, add such command line:
>
>  # qemu-system-aarch64 \
>        -accel kvm \
>        -cpu host,kvm-pmu-filter="D:0x11-0x11"
>
> Since the first action is deny, we have a global allow policy. This
> disables the filtering of the cycle counter (event 0x11 being CPU_CYCLES).
>
> And then in guest, use the perf to count the cycle:
>
>  # perf stat sleep 1
>
>   Performance counter stats for 'sleep 1':
>
>              1.22 msec task-clock                       #    0.001 CPUs utilized
>                 1      context-switches                 #  820.695 /sec
>                 0      cpu-migrations                   #    0.000 /sec
>                55      page-faults                      #   45.138 K/sec
>   <not supported>      cycles
>           1128954      instructions
>            227031      branches                         #  186.323 M/sec
>              8686      branch-misses                    #    3.83% of all branches
>
>       1.002492480 seconds time elapsed
>
>       0.001752000 seconds user
>       0.000000000 seconds sys
>
> As we can see, the cycle counter has been disabled in the guest, but
> other pmu events are still work.
>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


