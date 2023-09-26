Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527A97AEC26
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6rt-00053s-F4; Tue, 26 Sep 2023 08:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6rp-00053c-Q6
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6ro-0007mj-6y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695730119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aN3DPRuVPimaGZ3rllQaU/grK0W5FGXf00Dy/Q7PQYo=;
 b=DfNoLth+hUt78jhUmQkwrnVOse2/3c+R4tUKGNwUqiSHPDacqGxHGqRd1b9Rdk1EX/eCUt
 ahWC5pgdyO381UQA3wFgqFY+KWrmjzOf0pkF/63ZHMK43kR9z9mUhbKb1YXDU2eslC7wzk
 6BTGzo2GoH7i6a3iIBl6NrzgRsYb6R0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-8FwCgSoSNcOmAfIY_jDL-Q-1; Tue, 26 Sep 2023 08:08:35 -0400
X-MC-Unique: 8FwCgSoSNcOmAfIY_jDL-Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bff8e92054so128129621fa.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695730114; x=1696334914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aN3DPRuVPimaGZ3rllQaU/grK0W5FGXf00Dy/Q7PQYo=;
 b=O0s/y/2Eu3MCnSaghJcndEih8wBRAXwOn03rkTqrfO0XycM69i4ZQ8iGudzOQB/uum
 1Ro3de56kVKPjOFnHbIhgRSX+kbM2dauZu3V5NGVW9pqNmxbKdjK7WgkySBxcH2YSkpO
 2+Rnan0QYzlG3UxnNLYx4XdyedoIpOvvF65d4NeFrzH4Lz4JRNasPLBBcnV3GilvC9wd
 3Z0tc4mCdw8hW/MVDSnm4vGpg9Li4vQ8uNasRim0dA0Taf16/wji3ESbAYKB3QFxPUlo
 eX9lTJ8XnBMwEaXnFd2viFIE3dmUZAnSPmK/X7inhPBicjS9hCRpRcOi/KZV9Q6n+kNB
 PXow==
X-Gm-Message-State: AOJu0Yw2YKpE2Vj/f4+wl1hlnnlBMtM4wZCY7NZg0iojjCI4Lc6gfQFV
 2PySAEH0dMwYEJVy/71KzJb0kN3VLMXwsXgEBtLKbcfKwKjesRESytLGFo928p+S9pScjyGsrfW
 MB2yv/Q6V0eoHKms=
X-Received: by 2002:a2e:9987:0:b0:2bd:102c:4161 with SMTP id
 w7-20020a2e9987000000b002bd102c4161mr8229956lji.43.1695730114131; 
 Tue, 26 Sep 2023 05:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1klCZr9ipQe2iavmq1if2DNdn6oroUE6LlURObaSpbVTf/jYiN7nImqsyTWbalFP8V5jNAQ==
X-Received: by 2002:a2e:9987:0:b0:2bd:102c:4161 with SMTP id
 w7-20020a2e9987000000b002bd102c4161mr8229934lji.43.1695730113802; 
 Tue, 26 Sep 2023 05:08:33 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 ck17-20020a170906c45100b00992e14af9c3sm7748922ejb.143.2023.09.26.05.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:08:32 -0700 (PDT)
Date: Tue, 26 Sep 2023 08:08:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lixianglai <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Salil Mehta <salil.mehta@opnsrc.net>,
 Salil Mehta <salil.mehta@huawei.com>, Bernhard Beschow <shentey@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Song Gao <gaosong@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH v3 1/7] Update ACPI GED framework to support vcpu
 hot-(un)plug
Message-ID: <20230926080738-mutt-send-email-mst@kernel.org>
References: <cover.1695697701.git.lixianglai@loongson.cn>
 <14ee117df13b08403032eb07843b91e1861228d9.1695697701.git.lixianglai@loongson.cn>
 <20230926070229-mutt-send-email-mst@kernel.org>
 <bc29c4fe-7180-6e00-2e91-a6a89c37b85a@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc29c4fe-7180-6e00-2e91-a6a89c37b85a@loongson.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Sep 26, 2023 at 07:26:40PM +0800, lixianglai wrote:
> 
> Hi, Michael S. Tsirkin :
> > On Tue, Sep 26, 2023 at 05:54:26PM +0800, xianglai li wrote:
> > > ACPI GED shall be used to convey to the guest kernel about any cpu hot-(un)plug
> > > events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
> > > to support CPU hot-(un)plug state and events.
> > > 
> > > Co-authored-by: "Salil Mehta" <salil.mehta@opnsrc.net>
> > > Co-authored-by: "Salil Mehta" <salil.mehta@huawei.com>
> > This is not the way to handle multiple emails.
> 
> Oh, sorry, I'll delete the first one.
> 
> Thanks,
> 
> Xianglai.

Can you guys figure out together with Salil Mehta what's the
correct order to merge this? I can't figure out with dueling patches.


