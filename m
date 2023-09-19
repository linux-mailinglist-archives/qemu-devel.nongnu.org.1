Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE427A5BD3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:02:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVfr-0004sy-Q6; Tue, 19 Sep 2023 04:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qiVfn-0004si-9H
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qiVfl-0003OD-BC
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695110488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P93ZCyEq5L9IC0NewzFKIoFR6mCkPLjzanUK5tVHLT8=;
 b=CYXLxC57WXHUhwnW1ueFf9B/GZAUf829xM8MkXyBx9nJkoQO9ib6/lfkoeMlh4yAB5WADo
 J7NqK7bsstr5O01sm3dFZLRJHsQhsrmZMOXJ5Lza/GzcukmMoqLOu1J4Bt14DH/iS117Ar
 zKJxo4ZY1++wpNlZvw7MN8xWiaw04LI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-BrpuzUGiME2Wk-Ee0DYy7g-1; Tue, 19 Sep 2023 04:01:26 -0400
X-MC-Unique: BrpuzUGiME2Wk-Ee0DYy7g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so3637551f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 01:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110485; x=1695715285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P93ZCyEq5L9IC0NewzFKIoFR6mCkPLjzanUK5tVHLT8=;
 b=D6x9+BwiGOEoBVxOikMT4EIVYVxbVD66awzZi2iZp8rS0LIoS5SS1yWbbnCVeRN/qr
 0iG0PWvUQJXeI01Xjnw/BVA1DXsg291N6XxmoydI6wRCvYxVWqu+C+gXompEZCUXtfZO
 N6oMWPWRj5CViBI2vBEo6extEfvBkpXqysb45CDTaYfn8S4WQ5ZhFupwcFbgVJB6WsjO
 wG1bVCxh0TJVbEkGB8m4VDpDZh4Q+vyG8+OvP49giDaNqVcn/E58zZ7a0p1B0dwKfzmL
 X4Ej7f6CGoonHs/4p6PrChteNotEt42Fpin54eZ9yuUz5ogFkY9n2KIVHc38frAuTrUk
 OGOw==
X-Gm-Message-State: AOJu0YwpzXzbmw19BcsGK74paZ/eIY30mFbZ/dgsh/9EiAntR03p8Pt4
 6I6D7KRJ4gpFtMff3ydO97T3cz3KvJi3scVRbZXCPmEk0neeiGuOhpv9X/roIlbG4YHfqhWi637
 yLmOThBfLkWZ8KOs=
X-Received: by 2002:a05:6000:18cf:b0:31f:8276:5d04 with SMTP id
 w15-20020a05600018cf00b0031f82765d04mr8857132wrq.34.1695110485371; 
 Tue, 19 Sep 2023 01:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfU4qdlUJ8HuSX5k9T+1p9bgUyzSMEE0dayR7LTO9sTZPmF1+5JfTsJa6BKQRTb+ah1v8rkg==
X-Received: by 2002:a05:6000:18cf:b0:31f:8276:5d04 with SMTP id
 w15-20020a05600018cf00b0031f82765d04mr8857105wrq.34.1695110485063; 
 Tue, 19 Sep 2023 01:01:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i12-20020adffc0c000000b003197c7d08ddsm6820483wrr.71.2023.09.19.01.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 01:01:24 -0700 (PDT)
Date: Tue, 19 Sep 2023 10:01:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 15/16] tests: bios-tables-test: Add test for smbios
 type4 thread count2
Message-ID: <20230919100123.75e586b4@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZQlJzc5n+1V6YEDf@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-16-zhao1.liu@linux.intel.com>
 <20230915152907.4b6e63bc@imammedo.users.ipa.redhat.com>
 <ZQlJzc5n+1V6YEDf@liuzhao-OptiPlex-7080>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 19 Sep 2023 15:12:13 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> Hi Igor,
> 
> On Fri, Sep 15, 2023 at 03:29:07PM +0200, Igor Mammedov wrote:
> > Date: Fri, 15 Sep 2023 15:29:07 +0200
> > From: Igor Mammedov <imammedo@redhat.com>
> > Subject: Re: [PATCH 15/16] tests: bios-tables-test: Add test for smbios
> >  type4 thread count2
> > X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> > 
> > On Fri, 25 Aug 2023 11:36:18 +0800
> > Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> >   
> > > From: Zhao Liu <zhao1.liu@intel.com>
> > > 
> > > This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> > > type4").
> > > 
> > > Add this test to cover 2 cases:
> > > 1. Test thread count2 field with multiple sockets and multiple dies to
> > >    confirm this field could correctly calculate threads per sockets.
> > > 
> > > 2. Confirm that field calculation could correctly recognize the
> > >    difference between "-smp maxcpus" and "-smp cpus".
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > >  tests/qtest/bios-tables-test.c | 33 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > > 
> > > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > > index 26474d376633..1b0c27e95d26 100644
> > > --- a/tests/qtest/bios-tables-test.c
> > > +++ b/tests/qtest/bios-tables-test.c
> > > @@ -96,6 +96,7 @@ typedef struct {
> > >      uint8_t smbios_core_count;
> > >      uint16_t smbios_core_count2;
> > >      uint8_t smbios_thread_count;
> > > +    uint16_t smbios_thread_count2;
> > >      uint8_t *required_struct_types;
> > >      int required_struct_types_len;
> > >      int type4_count;
> > > @@ -644,6 +645,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> > >      uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
> > >      uint16_t speed, expected_speed[2];
> > >      uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
> > > +    uint16_t thread_count2, expected_thread_count2 = data->smbios_thread_count2;
> > >      int offset[2];
> > >      int i;
> > >  
> > > @@ -673,6 +675,8 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> > >      }
> > >  
> > >      if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> > > +        uint64_t thread_count2_addr;
> > > +
> > >          core_count2 = qtest_readw(data->qts,
> > >                            addr + offsetof(struct smbios_type_4, core_count2));
> > >  
> > > @@ -680,6 +684,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
> > >          if (expected_core_count == 0xFF && expected_core_count2) {
> > >              g_assert_cmpuint(core_count2, ==, expected_core_count2);
> > >          }
> > > +
> > > +        thread_count2_addr = addr +
> > > +                             offsetof(struct smbios_type_4, thread_count2);
> > > +        thread_count2 = qtest_readw(data->qts, thread_count2_addr);  
> > 
> > I'd mimic the same code style as used for core_count2 and avoid introducing an extra variable  
> 
> I'm not sure about the style of this case, since the code line is still
> too long, so which style should I pick? ;-)
> 
> thread_count2 = qtest_readw(data->qts,
>                     addr + offsetof(struct smbios_type_4,
> 		                    thread_count2));
> 
> or,


> thread_count2 = qtest_readw(data->qts,
>                     addr + offsetof(struct smbios_type_4,
>                     thread_count2));

this one

> 
> 
> >   
> > > +
> > > +        /* Thread Count has reached its limit, checking Thread Count 2 */
> > > +        if (expected_thread_count == 0xFF && expected_thread_count2) {
> > > +            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
> > > +        }
> > >      }
> > >  }
> > >  
> > > @@ -1050,6 +1063,7 @@ static void test_acpi_q35_tcg_thread_count(void)
> > >          .required_struct_types = base_required_struct_types,
> > >          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> > >          .smbios_thread_count = 27,
> > > +        .smbios_thread_count2 = 27,
> > >      };
> > >  
> > >      test_acpi_one("-machine smbios-entry-point-type=64 "
> > > @@ -1058,6 +1072,23 @@ static void test_acpi_q35_tcg_thread_count(void)
> > >      free_test_data(&data);
> > >  }
> > >  
> > > +static void test_acpi_q35_tcg_thread_count2(void)
> > > +{
> > > +    test_data data = {
> > > +        .machine = MACHINE_Q35,
> > > +        .variant = ".thread-count2",
> > > +        .required_struct_types = base_required_struct_types,
> > > +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> > > +        .smbios_thread_count = 0xFF,
> > > +        .smbios_thread_count2 = 260,
> > > +    };
> > > +
> > > +    test_acpi_one("-machine smbios-entry-point-type=64 "
> > > +                  "-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2",
> > > +                  &data);  
> > 
> > explain in commit message why abive -smp ==   
> 
> Ok, this is used to test if we could correctly distinguish smp.cpus and smp.maxcpus.
> 
> Thanks,
> Zhao
> 
> >   > +        .smbios_thread_count = 0xFF,
> >   > +        .smbios_thread_count2 = 260,  
> > 
> >   
> > > +    free_test_data(&data);
> > > +}
> > > +
> > >  static void test_acpi_q35_tcg_bridge(void)
> > >  {
> > >      test_data data = {};
> > > @@ -2216,6 +2247,8 @@ int main(int argc, char *argv[])
> > >                                 test_acpi_q35_tcg_core_count2);
> > >                  qtest_add_func("acpi/q35/thread-count",
> > >                                 test_acpi_q35_tcg_thread_count);
> > > +                qtest_add_func("acpi/q35/thread-count2",
> > > +                               test_acpi_q35_tcg_thread_count2);
> > >              }
> > >              qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> > >  #ifdef CONFIG_POSIX  
> >   
> 


