Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B424E7AEC23
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6qm-0003nm-T1; Tue, 26 Sep 2023 08:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6qd-0003g0-Ng
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6qb-0007US-0X
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695730043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4l7m1Dy6PHXgJ1KYHVd1dRJ/2ZYjTffvnhqK9NuXMlo=;
 b=heeegK1IW5ZsfS88Keq3U7DtU0FkM+vSai27D0P2gpfn/+5+9xpNpz8YoTeSrAEPT/esoB
 gEk1AAJD4zP9Zu+TNh0J94lFyjFM3z68Hm48WhETqYHtff/QjtskpzL/M+1jwxHNqsRI7i
 fQMtg+ILQMq8rwHPq+ph6DQB9A01xRc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-rhxiwJZJOiO1WkcN6sl9qw-1; Tue, 26 Sep 2023 08:07:21 -0400
X-MC-Unique: rhxiwJZJOiO1WkcN6sl9qw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-503177646d2so12625951e87.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695730039; x=1696334839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l7m1Dy6PHXgJ1KYHVd1dRJ/2ZYjTffvnhqK9NuXMlo=;
 b=RQ2q9VHk6kgTo/pvasRj5jK34eIZ1DyanyUZHv3Xla+gC0vadjCJbsGfJTTVYofnzp
 irqBOgiMopKq1GcNN/K1u7hBNr+DPB94nCwOTf90pL9gy0qaEDEh7GCaJ5na+9UNP96G
 W+O4ncg31ZyYGg+gCmVq43FibPhV7v3DMJEY2/yFikqV+5QgsJu48RBlMSqg8eTwAdgR
 jR62CgPWNBkcwsbWmb0CfMzOe9+9K/QPmTf0DGfKRL4lJVETJ73YPJ0IGrM/ERUGCNDF
 tGbaYUY9VdFqvZMzUhwIJewx+5UqzPd0ulP8CGOh2c0jeLzYCR6rzdHxL9amNP+09v5E
 nIFA==
X-Gm-Message-State: AOJu0Yz/xEscgGg5/kFjv6x/6qljbX3WtWujFUoOeWboNaj8GSqiLBqp
 eg7yXgdYuQ9sks1gTYasqN8/e1OmMPtH1/g10w76w9HMurERsfIRSQnsp2iWmv4cPThjjmBUc5r
 ay+XYXac57ypQvUcyANgK1FclvA==
X-Received: by 2002:a05:6512:158c:b0:503:32bb:d5ca with SMTP id
 bp12-20020a056512158c00b0050332bbd5camr10906126lfb.31.1695730039586; 
 Tue, 26 Sep 2023 05:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETy/5ZrCpmoaqcBY2S0iVGRHBv6PZFGvb/4PSMUVeLsrJ/9d6IKf7q6D8GBn3yQMLntiuZvQ==
X-Received: by 2002:a05:6512:158c:b0:503:32bb:d5ca with SMTP id
 bp12-20020a056512158c00b0050332bbd5camr10906103lfb.31.1695730039270; 
 Tue, 26 Sep 2023 05:07:19 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 fi9-20020a056402550900b00533bab9d9f1sm4133003edb.1.2023.09.26.05.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:07:18 -0700 (PDT)
Date: Tue, 26 Sep 2023 08:07:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: xianglai li <lixianglai@loongson.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, Salil Mehta <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 2/7] Update CPUs AML with cpu-(ctrl)dev change
Message-ID: <20230926080436-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <c2ab409710f5e0f0346727b47aaabd14537d45b8.1695697701.git.lixianglai@loongson.cn>
 <17a09b8ab65542be8561cb0480dae6bd@huawei.com>
 <20230926071055-mutt-send-email-mst@kernel.org>
 <4cc68780b63f47879d757fe604f37892@huawei.com>
 <20230926074945-mutt-send-email-mst@kernel.org>
 <54482e7486564d68926ded075ebe8c6f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54482e7486564d68926ded075ebe8c6f@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 26, 2023 at 12:03:46PM +0000, Salil Mehta wrote:
> Sure, ARM patch-set follows exactly above rules.
> 


Almost.

	Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
	Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
	Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
	Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
	Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

You should drop your own Co-developed-by as well as multiple Signed-off-by.

-- 
MST


