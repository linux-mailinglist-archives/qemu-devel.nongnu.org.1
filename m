Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A7723B0E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 10:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Rn0-0007p2-KG; Tue, 06 Jun 2023 04:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6Rmy-0007of-PY
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 04:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6Rmx-0006pZ-8B
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 04:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686039094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fz2SfKFc/LXhQIx3dc6hqVkkIJSY/5qVYTrcjYQ8kyo=;
 b=TBczDE/6JhD5BYdb8JDX8sNDks1RMjZH0UiYWZG0fy6V0orYS/BPg+CzTrsQl5/XwmBN3+
 0MmhpnTZTxZQ8OAXtmqtJ+QFqZ56I8WDvpU9DRlRFNhgLKxEdfeVSTxgFHgh8sLZzm8eer
 c17OZl7dRfN+pO8p1wu02VMeC5cZbJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-k7hm4WvINFSITVqHM7jUyw-1; Tue, 06 Jun 2023 04:11:28 -0400
X-MC-Unique: k7hm4WvINFSITVqHM7jUyw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355cf318so468682666b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 01:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686039086; x=1688631086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fz2SfKFc/LXhQIx3dc6hqVkkIJSY/5qVYTrcjYQ8kyo=;
 b=FZNhxctYLSLCbPSO5c//+fov6iXl0hBpStYOix5w+lOAtbd7fsxvmmBCKxpsp4JROa
 CI9gZFL/MAn/CWFWcj9EVKM/5CIDusmsE5putK95POhrC/zaiSWQUsX+NSbQe1XsXdqv
 srQxK2l5ln4V45WCevhUSNqe0A3I3lGkZQWSwcLizUiG6y8JO6g969tG6zv58O1P35Ax
 RIxjrG2iFJnqBw6DhqRNRtH0+MtNq02EqahIq+ANyvnHuAliCwgYLF+T3yLeaIBnr3j6
 c6pdcmCtOgKhUOQnIxocGcTW4spJr/dsBC9koJo1SfLHIcbsEJ0iyP90Eca5tmmNtAwC
 Oi2g==
X-Gm-Message-State: AC+VfDwsvZvj4QZTmxznqaVtr5hdd2hn7hO4dZjJtCTukW4zKjlrGtlS
 qnmWPDdYWrTp1G1sJHd0wqNnpMfEnnyGbqtnL3DOv9q6/HMON3mzWX5o5RRSCsFFnbvkkI2ihpo
 07++4sxBzVkA+Pgxq4q0l/O0=
X-Received: by 2002:a17:907:97c4:b0:966:1984:9d21 with SMTP id
 js4-20020a17090797c400b0096619849d21mr1578845ejc.9.1686039085877; 
 Tue, 06 Jun 2023 01:11:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7esFd7WyA77ebA+mLbvc3tssnlF8JkSc/hIbL9n9WIa3qNR+uWrpyRa4zLwb0rpGVoYonQ/A==
X-Received: by 2002:a17:907:97c4:b0:966:1984:9d21 with SMTP id
 js4-20020a17090797c400b0096619849d21mr1578817ejc.9.1686039085570; 
 Tue, 06 Jun 2023 01:11:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d10-20020a170906640a00b00965e1be3002sm5269901ejm.166.2023.06.06.01.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 01:11:25 -0700 (PDT)
Date: Tue, 6 Jun 2023 10:11:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v4 2/3] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <20230606101124.7d252fae@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230606093541.5a2e6b87@imammedo.users.ipa.redhat.com>
References: <20230605213906.644883-1-suravee.suthikulpanit@amd.com>
 <20230605213906.644883-3-suravee.suthikulpanit@amd.com>
 <20230606093541.5a2e6b87@imammedo.users.ipa.redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 6 Jun 2023 09:35:41 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 5 Jun 2023 16:39:05 -0500
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
[...]
> > +    /* For pc-i44fx-8.0 and older, use SMBIOS 2.8 by default */
> > +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
> >  }
[...]
> >  static void pc_q35_8_0_machine_options(MachineClass *m)
> >  {
[...]
> > +    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
> > +    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
> >  }
[...]

what Michael referred to as duplication is probably these lines,
however "smbios-entry-point-type: is machine property so we can't
use device compat machinery here (pc_compat_8_0).
What we can do is override "default_machine_opts" value, but then
again it has to be opencoded in  piix4/q35_machine_options, so
don't see a point in doing so.
As you wrote here is what typically do for machine compat knobs,
so it should be fine.

I just doubt that we need extra default_smbios_ep_type field.


