Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D171C93D3F4
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jul 2024 15:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKmO-0000ah-4N; Fri, 26 Jul 2024 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKmE-0000ZP-Vs
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sXKmB-00064X-Op
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721999665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEiHh5gKYu2aAteljFklWJEd9UWqkmgr0EA7AbaB1O8=;
 b=e49qRVCL2x0Bm0ZrKbAeJ1isLjVyZ22Ojq7UqXVGgrA9QIjiM25Zf461n6xLxBXyG4x6m9
 4gPZLap8UzWUysl3f46hAnxQzys/gUGzC5H3A4p7XfwequXkc2eiPH8a8D7NGzgS3+d4Df
 jmtdSrVp9JZjoYVxwZG1pdkSQZLtaCk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-iBvCp3iaPZyqRNGXO0A6-Q-1; Fri, 26 Jul 2024 09:14:24 -0400
X-MC-Unique: iBvCp3iaPZyqRNGXO0A6-Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ef2907e21bso11184401fa.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721999662; x=1722604462;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MEiHh5gKYu2aAteljFklWJEd9UWqkmgr0EA7AbaB1O8=;
 b=ohvxje8+T2+RxPbIkLsuDN5XaBubY1UyMlDLEMkpXFeVexTSaEPUMGqVKhg8d50/A4
 J24dqmdZazqs1SBh6NO6DcRv1fQ+e3iDWieQSgO78AoTAl6tSGYadurxTPL86ApKX7YF
 neeeZQSJOFBjkezujmnM8VO190d5p1b/OreBV9VbOTTECMW8gAmxonFDIWcxv/TjTaRN
 XjMWjAAbx0+KakofUKISLbzbngEdZIwTv2nRqbI6x18pn/5BeY3OO+ZDBeZs+gHmvsZ3
 14Pvh4b+NCXebGEZrylCdkz4Y/C6BqDjZ8LAOIO5tvIdmKXlvsmRzsMaDTIBwdqhyZ8j
 wz2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc1WPunbJYFFrjOBIq6p+B2PNz+ojU2jM7cSU6o29fIooi0uwteZHlHSTmjs2USmQYZ8Gbka0INd+3WL0eRDzA7+/oqh8=
X-Gm-Message-State: AOJu0Yy6Qs/xLSPX/1Ud7+jNFbZZWZ6JQhDOsZk2w8Yjcb3XtGs8LNmm
 5uhtagjV+FqF2iUgRl9ZsFzZ8k/zLCqoOVsjBovP8y7xRh/1bTRshPkQVuIpWR40o07MKMPWTPC
 +5nJHDyCv6kX731D1tbmmuLxeKfsNj12/kep9fknAgXamVEZRQu1/
X-Received: by 2002:a05:651c:481:b0:2ed:5c34:4082 with SMTP id
 38308e7fff4ca-2f039c4e382mr38779071fa.8.1721999662258; 
 Fri, 26 Jul 2024 06:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF53rKt2uVwvXPDaQM7yGiiu7wlme1aY9rCv4gUf+mdi8bDRhOJvxRm12JCuaLvhRxpT162Ig==
X-Received: by 2002:a05:651c:481:b0:2ed:5c34:4082 with SMTP id
 38308e7fff4ca-2f039c4e382mr38778391fa.8.1721999661205; 
 Fri, 26 Jul 2024 06:14:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm79169445e9.19.2024.07.26.06.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 06:14:20 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:14:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2] ptp: Add vDSO-style vmclock support
Message-ID: <20240726090538-mutt-send-email-mst@kernel.org>
References: <7b3a2490d467560afd2fe08d4f28c4635919ec48.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b3a2490d467560afd2fe08d4f28c4635919ec48.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, Jul 26, 2024 at 01:28:17PM +0100, David Woodhouse wrote:
> diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmclock-abi.h
> new file mode 100644
> index 000000000000..7b1b4759363c
> --- /dev/null
> +++ b/include/uapi/linux/vmclock-abi.h
> @@ -0,0 +1,187 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
> +
> +/*
> + * This structure provides a vDSO-style clock to VM guests, exposing the
> + * relationship (or lack thereof) between the CPU clock (TSC, timebase, arch
> + * counter, etc.) and real time. It is designed to address the problem of
> + * live migration, which other clock enlightenments do not.
> + *
> + * When a guest is live migrated, this affects the clock in two ways.
> + *
> + * First, even between identical hosts the actual frequency of the underlying
> + * counter will change within the tolerances of its specification (typically
> + * �50PPM, or 4 seconds a day). This frequency also varies over time on the
> + * same host, but can be tracked by NTP as it generally varies slowly. With
> + * live migration there is a step change in the frequency, with no warning.
> + *
> + * Second, there may be a step change in the value of the counter itself, as
> + * its accuracy is limited by the precision of the NTP synchronization on the
> + * source and destination hosts.
> + *
> + * So any calibration (NTP, PTP, etc.) which the guest has done on the source
> + * host before migration is invalid, and needs to be redone on the new host.
> + *
> + * In its most basic mode, this structure provides only an indication to the
> + * guest that live migration has occurred. This allows the guest to know that
> + * its clock is invalid and take remedial action. For applications that need
> + * reliable accurate timestamps (e.g. distributed databases), the structure
> + * can be mapped all the way to userspace. This allows the application to see
> + * directly for itself that the clock is disrupted and take appropriate
> + * action, even when using a vDSO-style method to get the time instead of a
> + * system call.
> + *
> + * In its more advanced mode. this structure can also be used to expose the
> + * precise relationship of the CPU counter to real time, as calibrated by the
> + * host. This means that userspace applications can have accurate time
> + * immediately after live migration, rather than having to pause operations
> + * and wait for NTP to recover. This mode does, of course, rely on the
> + * counter being reliable and consistent across CPUs.
> + *
> + * Note that this must be true UTC, never with smeared leap seconds. If a
> + * guest wishes to construct a smeared clock, it can do so. Presenting a
> + * smeared clock through this interface would be problematic because it
> + * actually messes with the apparent counter *period*. A linear smearing
> + * of 1 ms per second would effectively tweak the counter period by 1000PPM
> + * at the start/end of the smearing period, while a sinusoidal smear would
> + * basically be impossible to represent.
> + *
> + * This structure is offered with the intent that it be adopted into the
> + * nascent virtio-rtc standard, as a virtio-rtc that does not address the live
> + * migration problem seems a little less than fit for purpose. For that
> + * reason, certain fields use precisely the same numeric definitions as in
> + * the virtio-rtc proposal. The structure can also be exposed through an ACPI
> + * device with the CID "VMCLOCK", modelled on the "VMGENID" device except for
> + * the fact that it uses a real _CRS to convey the address of the structure
> + * (which should be a full page, to allow for mapping directly to userspace).
> + */
> +
> +#ifndef __VMCLOCK_ABI_H__
> +#define __VMCLOCK_ABI_H__
> +
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#else
> +#include <stdint.h>
> +#endif
> +
> +struct vmclock_abi {
> +	/* CONSTANT FIELDS */
> +	uint32_t magic;
> +#define VMCLOCK_MAGIC	0x4b4c4356 /* "VCLK" */
> +	uint32_t size;		/* Size of region containing this structure */
> +	uint16_t version;	/* 1 */
> +	uint8_t counter_id; /* Matches VIRTIO_RTC_COUNTER_xxx except INVALID */
> +#define VMCLOCK_COUNTER_ARM_VCNT	0
> +#define VMCLOCK_COUNTER_X86_TSC		1
> +#define VMCLOCK_COUNTER_INVALID		0xff
> +	uint8_t time_type; /* Matches VIRTIO_RTC_TYPE_xxx */
> +#define VMCLOCK_TIME_UTC			0	/* Since 1970-01-01 00:00:00z */
> +#define VMCLOCK_TIME_TAI			1	/* Since 1970-01-01 00:00:00z */
> +#define VMCLOCK_TIME_MONOTONIC			2	/* Since undefined epoch */
> +#define VMCLOCK_TIME_INVALID_SMEARED		3	/* Not supported */
> +#define VMCLOCK_TIME_INVALID_MAYBE_SMEARED	4	/* Not supported */
> +
> +	/* NON-CONSTANT FIELDS PROTECTED BY SEQCOUNT LOCK */
> +	uint32_t seq_count;	/* Low bit means an update is in progress */
> +	/*
> +	 * This field changes to another non-repeating value when the CPU
> +	 * counter is disrupted, for example on live migration. This lets
> +	 * the guest know that it should discard any calibration it has
> +	 * performed of the counter against external sources (NTP/PTP/etc.).
> +	 */
> +	uint64_t disruption_marker;
> +	uint64_t flags;
> +	/* Indicates that the tai_offset_sec field is valid */
> +#define VMCLOCK_FLAG_TAI_OFFSET_VALID		(1 << 0)
> +	/*
> +	 * Optionally used to notify guests of pending maintenance events.
> +	 * A guest which provides latency-sensitive services may wish to
> +	 * remove itself from service if an event is coming up. Two flags
> +	 * indicate the approximate imminence of the event.
> +	 */
> +#define VMCLOCK_FLAG_DISRUPTION_SOON		(1 << 1) /* About a day */
> +#define VMCLOCK_FLAG_DISRUPTION_IMMINENT	(1 << 2) /* About an hour */
> +#define VMCLOCK_FLAG_PERIOD_ESTERROR_VALID	(1 << 3)
> +#define VMCLOCK_FLAG_PERIOD_MAXERROR_VALID	(1 << 4)
> +#define VMCLOCK_FLAG_TIME_ESTERROR_VALID	(1 << 5)
> +#define VMCLOCK_FLAG_TIME_MAXERROR_VALID	(1 << 6)
> +	/*
> +	 * If the MONOTONIC flag is set then (other than leap seconds) it is
> +	 * guaranteed that the time calculated according this structure at
> +	 * any given moment shall never appear to be later than the time
> +	 * calculated via the structure at any *later* moment.
> +	 *
> +	 * In particular, a timestamp based on a counter reading taken
> +	 * immediately after setting the low bit of seq_count (and the
> +	 * associated memory barrier), using the previously-valid time and
> +	 * period fields, shall never be later than a timestamp based on
> +	 * a counter reading taken immediately before *clearing* the low
> +	 * bit again after the update, using the about-to-be-valid fields.
> +	 */
> +#define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)
> +
> +	uint8_t pad[2];
> +	uint8_t clock_status;
> +#define VMCLOCK_STATUS_UNKNOWN		0
> +#define VMCLOCK_STATUS_INITIALIZING	1
> +#define VMCLOCK_STATUS_SYNCHRONIZED	2
> +#define VMCLOCK_STATUS_FREERUNNING	3
> +#define VMCLOCK_STATUS_UNRELIABLE	4
> +
> +	/*
> +	 * The time exposed through this device is never smeared. This field
> +	 * corresponds to the 'subtype' field in virtio-rtc, which indicates
> +	 * the smearing method. However in this case it provides a *hint* to
> +	 * the guest operating system, such that *if* the guest OS wants to
> +	 * provide its users with an alternative clock which does not follow
> +	 * UTC, it may do so in a fashion consistent with the other systems
> +	 * in the nearby environment.
> +	 */
> +	uint8_t leap_second_smearing_hint; /* Matches VIRTIO_RTC_SUBTYPE_xxx */
> +#define VMCLOCK_SMEARING_STRICT		0
> +#define VMCLOCK_SMEARING_NOON_LINEAR	1
> +#define VMCLOCK_SMEARING_UTC_SLS	2
> +	int16_t tai_offset_sec;
> +	uint8_t leap_indicator;
> +	/*
> +	 * This field is based on the the VIRTIO_RTC_LEAP_xxx values as
> +	 * defined in the current draft of virtio-rtc, but since smearing
> +	 * cannot be used with the shared memory device, some values are
> +	 * not used.
> +	 *
> +	 * The _POST_POS and _POST_NEG values allow the guest to perform
> +	 * its own smearing during the day or so after a leap second when
> +	 * such smearing may need to continue being applied for a leap
> +	 * second which is now theoretically "historical".
> +	 */
> +#define VMCLOCK_LEAP_NONE	0x00	/* No known nearby leap second */
> +#define VMCLOCK_LEAP_PRE_POS	0x01	/* Positive leap second at EOM */
> +#define VMCLOCK_LEAP_PRE_NEG	0x02	/* Negative leap second at EOM */
> +#define VMCLOCK_LEAP_POS	0x03	/* Set during 23:59:60 second */
> +#define VMCLOCK_LEAP_POST_POS	0x04
> +#define VMCLOCK_LEAP_POST_NEG	0x05
> +
> +	/* Bit shift for counter_period_frac_sec and its error rate */
> +	uint8_t counter_period_shift;
> +	/*
> +	 * Paired values of counter and UTC at a given point in time.
> +	 */
> +	uint64_t counter_value;
> +	/*
> +	 * Counter period, and error margin of same. The unit of these
> +	 * fields is 1/2^(64 + counter_period_shift) of a second.
> +	 */
> +	uint64_t counter_period_frac_sec;
> +	uint64_t counter_period_esterror_rate_frac_sec;
> +	uint64_t counter_period_maxerror_rate_frac_sec;
> +
> +	/*
> +	 * Time according to time_type field above.
> +	 */
> +	uint64_t time_sec;		/* Seconds since time_type epoch */
> +	uint64_t time_frac_sec;		/* Units of 1/2^64 of a second */
> +	uint64_t time_esterror_nanosec;
> +	uint64_t time_maxerror_nanosec;
> +};
> +
> +#endif /*  __VMCLOCK_ABI_H__ */

For purposes of virtio, should we label all the fields here
__le?


> -- 
> 2.44.0
> 
> 



