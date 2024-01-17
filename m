Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD1C830B11
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:31:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8nM-0006tG-SJ; Wed, 17 Jan 2024 11:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rQ8nK-0006sI-Jf
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:29:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rQ8nJ-000531-4v
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705508976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkyNsJCwFGqJTPhySJfa88JUu1UflHNy/NLPsLpoA3A=;
 b=fgtnriViNFuWkCG3HHVJSTIW01CLBC/M67DdCtQErOzmW7wgjndYFmaNXpUQW6QeGvwwzR
 AsjKlGAr/q9UOQgswfNW7owrv+eeFC1oyvBPhBdzQdVf511GgTv2HrpfY2jgu9ZvVn9kx3
 AvYuygkUmTgXof2jk7e6EWUt7xJzCsM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-GxsfgPZPPXK_D8JZy-5JYQ-1; Wed, 17 Jan 2024 11:29:34 -0500
X-MC-Unique: GxsfgPZPPXK_D8JZy-5JYQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42987be5d14so149308431cf.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 08:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705508974; x=1706113774;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkyNsJCwFGqJTPhySJfa88JUu1UflHNy/NLPsLpoA3A=;
 b=ElHSDz4SOrN95YH+Ztqe2RT4la1GXrCl8oC1JCwr8kTSoUV5piDyR7irTHZABG2PzY
 R+NTg0T4M1jNHws8XxE6jbqLV3LgmTjEa5HRGPMt5BdGHAZbredtS16C3BkEx/lZSRQI
 lR02E7EttSRqjcy4PxitLpU7m8JVDtm7YsMeeQ1uo8k4WoxTRgBG7MM+vHBq+1JBqPNl
 kmIgqgYqL/P0kew2Q3irD3yW9ujaO7gKZqvtZTNB0o08iBa4bSLBqYC2Cr1tPJaLNcFz
 NhzfoAjKzys4y/wyu0qbWKtkjS4pqfdyxINFxH1Tr1pwxnGDqk0eFQlXroGxSOk6QedY
 Db+w==
X-Gm-Message-State: AOJu0YxxXCePPYqDmuZhd0PeUo1CSpPvCKnLR+kA+CN0dYVsXXYkBomW
 gxl9WXz9LlzZTYLNpciNuU+H3amES06tLJcl9DKuPkFUQNv3a30LBzHL0TTYO1M8h7BcWo58pqO
 1JezYfvCrXkQ+KrrOFNYkVzQ=
X-Received: by 2002:a05:622a:291:b0:42a:ccf:9f85 with SMTP id
 z17-20020a05622a029100b0042a0ccf9f85mr2081553qtw.130.1705508974482; 
 Wed, 17 Jan 2024 08:29:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmlmbNMod+UjUJxjrvx7sc+Nzs2mXpWaJhW4PSvRl+e+9dFXoXA9RoTWAn/W/svgXJQBX8CQ==
X-Received: by 2002:a05:622a:291:b0:42a:ccf:9f85 with SMTP id
 z17-20020a05622a029100b0042a0ccf9f85mr2081544qtw.130.1705508974279; 
 Wed, 17 Jan 2024 08:29:34 -0800 (PST)
Received: from rh (p200300c93f0273004f0fe90936098834.dip0.t-ipconnect.de.
 [2003:c9:3f02:7300:4f0f:e909:3609:8834])
 by smtp.gmail.com with ESMTPSA id
 eq23-20020a05622a5e1700b0042992b06012sm5998976qtb.2.2024.01.17.08.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:29:34 -0800 (PST)
Date: Wed, 17 Jan 2024 17:29:30 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org, 
 Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 kvm@vger.kernel.org
Subject: Re: [PATCH v5] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
In-Reply-To: <852ee2a3-b69f-4480-a6f4-f2b274f5e01c@redhat.com>
Message-ID: <36a1efb3-2538-c339-d627-843e7d2b6541@redhat.com>
References: <20240115080144.44944-1-shahuang@redhat.com>
 <852ee2a3-b69f-4480-a6f4-f2b274f5e01c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 17 Jan 2024, Eric Auger wrote:
> On 1/15/24 09:01, Shaoqin Huang wrote:
>> +    /*
>> +     * The filter only needs to be initialized through one vcpu ioctl and it
>> +     * will affect all other vcpu in the vm.
>> +     */
>> +    if (pmu_filter_init) {
> I think I commented on that on the v4. Maybe I missed your reply. You
> sure you don't need to call it for each vcpu?

From (kernel) commit d7eec2360e3 ("KVM: arm64: Add PMU event filtering
infrastructure"):
   Note that although the ioctl is per-vcpu, the map of allowed events is
   global to the VM (it can be setup from any vcpu until the vcpu PMU is
   initialized).

Sebastian


