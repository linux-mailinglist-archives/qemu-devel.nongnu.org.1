Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C2753A2D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHJf-0007iB-R1; Fri, 14 Jul 2023 07:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKHJe-0007hu-1M
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKHJb-0002IG-JT
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689335425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oj7NafbvUOzrd5AUQ+cQG+R5tyDTsehfiX1whcx7BpU=;
 b=OBIHUMBGrsSG7bY/rjCaPXTUYRXYuMiS+6LhxyUiscHlZ3z/LSzSMQPYCL5u9O90owBq+C
 fK62YPQtyPoBUuk3qdhxKmwmZMNlraVoHqnzTJoR8YrXiphtmE4HrFKXqhLuXNhwckbfN8
 6YKs17FSPVdYNmM9Qqfa/3Qnez2VH5g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-XwQbFakXMMOUeQ0U5B8Bgw-1; Fri, 14 Jul 2023 07:50:22 -0400
X-MC-Unique: XwQbFakXMMOUeQ0U5B8Bgw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so110372866b.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689335406; x=1691927406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oj7NafbvUOzrd5AUQ+cQG+R5tyDTsehfiX1whcx7BpU=;
 b=aZpg5eLuwFyetNaO0A46WZbuVNB0Lj22PGw3lZf40nXnWIkoyNlVhQPNE0zmAM8T8S
 WdI8SpLfuRTX+We5GqJl7mNkocyOWSKvoPdSoFsY8ARv+MEoXM4C6YgcGPFVnXT3Z+TK
 dAS+yJnDZ8Gihm9eS6n/bEwGrjih11rozqg0E+bIJ2RXldnVfRuxIhiCpendFnhQHnBy
 HOwNNXfytrlnWsqQgsbeGb5DocH6d/tMVttXjNyva6AVtvnARCCxc+yJYnwtOgSdF4fk
 c0VZZ6yOPFSde7be2Gtn0d/UBwMKif1f9aLbeuUGgYvIZKq7dY/2YcPa570/jIsdqcJn
 M2RQ==
X-Gm-Message-State: ABy/qLY3I3XZIDG8TiThWYYwv3Rebn2lseXUbHW4gakVFd6wVIGl1/Ie
 bm6T3teFMMBuF6kMjYqRojM7Tu1NDw1kXIEOQsitFc283rvrN2VoyOh365+LaqSCkI5t95oV2Hs
 hIYatJt/4C8669lg=
X-Received: by 2002:a17:906:52da:b0:98f:5640:16a with SMTP id
 w26-20020a17090652da00b0098f5640016amr4222617ejn.53.1689335405782; 
 Fri, 14 Jul 2023 04:50:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/+iqn55hBvrrN6jLYDLpUC8JXXZerxIMFemT7lAK2H/SyxeGs2K1dPXs2IEnHT8Qssh/DGw==
X-Received: by 2002:a17:906:52da:b0:98f:5640:16a with SMTP id
 w26-20020a17090652da00b0098f5640016amr4222599ejn.53.1689335405446; 
 Fri, 14 Jul 2023 04:50:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 v19-20020a1709061dd300b00992f81122e1sm5292364ejh.21.2023.07.14.04.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 04:50:04 -0700 (PDT)
Date: Fri, 14 Jul 2023 13:50:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Gavin Shan
 <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
Message-ID: <20230714135004.230c05b2@imammedo.users.ipa.redhat.com>
In-Reply-To: <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
 <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 13 Jul 2023 12:59:55 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 13 Jul 2023 at 12:52, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
> >
> > W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
> >  
> > > I see this isn't a change in this patch, but given that
> > > what the user specifies is not "cortex-a8-arm-cpu" but
> > > "cortex-a8", why do we include the "-arm-cpu" suffix in
> > > the error messages? It's not valid syntax to say
> > > "-cpu cortex-a8-arm-cpu", so it's a bit misleading...  
> >
> > Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for
> > other architectures.  
> 
> Yes; my question is "why are we not using the user-facing
> string rather than the internal type name?".

With other targets full CPU type name can also be valid
user-facing string. Namely we use it with -device/device_add
interface. Considering we would like to have CPU hotplug
on ARM as well, we shouldn't not outlaw full type name.
(QMP/monitor interface also mostly uses full type names)

Instead it might be better to consolidate on what has
been done on making CPU '-device' compatible and
allow to use full CPU type name with '-cpu' on arm machines.

Then later call suffix-less legacy => deprecate/drop it from
user-facing side including cleanup of all the infra we've
invented to keep mapping between cpu_model and typename.

With that gone, listing/restricting (supported) cpu types
can be done without extra processing and likely can be
done in one place for all targets/cpus instead of zoo
we have now.
(extra bonus: all error messages that include
CPU name will become consistent with the rest as well,
since only CPU typename is left around)
 
> -- PMM
> 


