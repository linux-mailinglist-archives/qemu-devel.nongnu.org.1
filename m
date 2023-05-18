Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21054707EC2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbQ3-0000lt-MA; Thu, 18 May 2023 07:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbQ1-0000lV-KZ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbQ0-0004nI-3X
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684407815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjjAowIMG3YA+/BgxLi0dmJ/8ONg/3NJSyZwgxr8hNc=;
 b=VpSnjCyTexfLCwmIcNJA9Opa2pwdWXoEBrytJjhT+PNRvnfuWbVkVfK1pTMxRdaYPcWF9b
 GhP0Cs+OGavE5ekhSQxX6PKnHaeF/IxNcTRKFpjUWWiCyt57jTZmiX5J6ys27aeYr+zb5Z
 XtD/rOCSF5mGtS4G7qf4yq6B1ga4JD4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-YecJZYBQNWKZJ92TDe-07w-1; Thu, 18 May 2023 07:03:32 -0400
X-MC-Unique: YecJZYBQNWKZJ92TDe-07w-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-64385416769so2129488b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684407812; x=1686999812;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EjjAowIMG3YA+/BgxLi0dmJ/8ONg/3NJSyZwgxr8hNc=;
 b=V5O5g7ezmoChtMAHbjVjWNzPb1uyYkNJn/9xne+Kg9iswWTVnXk/YmmsX3lSJplwu4
 4Ge+0ObRHmro+gF15ImmgmXyyj9XrdgwI8X599mAXWwXyJmQ9ZHanmRcXTGUoo0lI0VK
 JpzMp1i6ttTfPWfUa9dOZD4Cuk2rRQi9pL8EDdpJHHCGUbmGsBui4mlSmLgqnrDqaWaB
 lR4/C+bU9EK2d3V7hDPr6Fx14ESYdwvfQ7lBSFIewOU6Rw7KW20ltIFL5vGMYVjlM9XP
 8e1jVNCDdhA18ZcTzZtmYbG8xaJa72ysrTGcm0Sw9rEFZgpOaXM6Q85rDR2QvQemjvDv
 91dA==
X-Gm-Message-State: AC+VfDw8DQWVhUfkVkSMJ/vL4IIf32OuRyTx2+eCOgSWedt2F1ta2E87
 tdZL1QfCMGvGwmOin9/mDQ0U7Fna6EW4G/FYSEtAHNw9zAzmnIEPOhKM+/HFwCuC9C3ripkDuLH
 gJMulrRYtyqvLQ0k=
X-Received: by 2002:a05:6a20:d38d:b0:107:10b6:4c84 with SMTP id
 iq13-20020a056a20d38d00b0010710b64c84mr2023178pzb.21.1684407811801; 
 Thu, 18 May 2023 04:03:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+uu9Kb3YwNVc3V0n5bWcX8lmVusm0uH8F829Ih8tC8Qfhl0d1ncbDDdEQ9EOpvW5K0Pnreg==
X-Received: by 2002:a05:6a20:d38d:b0:107:10b6:4c84 with SMTP id
 iq13-20020a056a20d38d00b0010710b64c84mr2023149pzb.21.1684407811449; 
 Thu, 18 May 2023 04:03:31 -0700 (PDT)
Received: from fc37-ani ([115.96.106.170])
 by smtp.googlemail.com with ESMTPSA id
 j8-20020a63cf08000000b00502e7115cbdsm1023100pgg.51.2023.05.18.04.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:03:30 -0700 (PDT)
Date: Thu, 18 May 2023 16:33:24 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, 
 boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Subject: Re: [PATCH v2 1/3] ACPI: bios-tables-test.c step 2 (allowed-diff
 entries)
In-Reply-To: <20230517162545.2191-2-eric.devolder@oracle.com>
Message-ID: <7d653232-1b9b-29f3-dd56-e50fc4e31893@redhat.com>
References: <20230517162545.2191-1-eric.devolder@oracle.com>
 <20230517162545.2191-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On Wed, 17 May 2023, Eric DeVolder wrote:

> Following the guidelines in tests/qtest/bios-tables-test.c,
> set up bios-tables-test-allowed-diff.h to ignore the
> imminent changes to the APIC tables, per step 2.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Acked-by: Ani Sinha <ani@anisinha.ca>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..66ae44e6b9 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,15 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/microvm/APIC",
> +"tests/data/acpi/microvm/APIC.ioapic2",
> +"tests/data/acpi/microvm/APIC.pcie",
> +"tests/data/acpi/pc/APIC",
> +"tests/data/acpi/pc/APIC.acpihmat",
> +"tests/data/acpi/pc/APIC.cphp",
> +"tests/data/acpi/pc/APIC.dimmpxm",
> +"tests/data/acpi/q35/APIC",
> +"tests/data/acpi/q35/APIC.acpihmat",
> +"tests/data/acpi/q35/APIC.acpihmat-noinitiator",
> +"tests/data/acpi/q35/APIC.core-count2",
> +"tests/data/acpi/q35/APIC.cphp",
> +"tests/data/acpi/q35/APIC.dimmpxm",
> +"tests/data/acpi/q35/APIC.xapic",
> --
> 2.31.1
>
>


