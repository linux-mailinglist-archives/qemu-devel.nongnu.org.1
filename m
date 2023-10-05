Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4855F7BA638
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRH1-00060g-OL; Thu, 05 Oct 2023 12:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoRGz-00060G-I5
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoRGx-0008O6-9U
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696523540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OaDrqN2qavkd/DVrhxhzY6NWAtIB1EyrIVAfuPoCkGw=;
 b=dGiSU9Bcx0Jg9AbmHWqPXCyGFO3doAfi75Roux29zOXTAwe79qWDN97k56daZkc7a6FJLF
 fvmJ/SUPoj9MC7b1rRBIjt62D/woTfOrCHzKEZWbf2LY8FQkamrwt7LUMKiIRRYTXj0XuE
 CA4uqCAxF5u5Gi+Ii+a6nEorF3H6oxk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-RBI1gWGuP3-f--kt4h_wcg-1; Thu, 05 Oct 2023 12:32:18 -0400
X-MC-Unique: RBI1gWGuP3-f--kt4h_wcg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso7140395e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696523538; x=1697128338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaDrqN2qavkd/DVrhxhzY6NWAtIB1EyrIVAfuPoCkGw=;
 b=vXD5JTTG4W03Juasr8DMvrFrN4bq8EPfT0s1T9XUEm6Ll/2nftLONQlQelqQiR8A1k
 cmi5a5O9vExClXgxyPiQY3AbRcAXjVymjucZ67BuslmZsMb4e+iwLWINlx6E1CxsFvaL
 LXQ0MNW8K2CA58ILlkcm8yOkAb0T0eKEQkDqDKqKRE/5euS+URc9ryTJV83Jtsd5GdFf
 UGT5QMdfFUFiH+8se8W/aFwq7cLYyzua1qUOk6XLOwGmdfDRjqeTbQQFGSv7DnfwyEmy
 22zVfN6DCUdXFNaViBHW16f737/tNKdWpYi+UIsuzeGieyLQrgvgYlxCQRXnQLELi6wq
 WS1w==
X-Gm-Message-State: AOJu0YzA7cLYrQVmGf5cKxcbQaobNFAm6gXGCWXW4k1O0PrHpr8g8DbO
 Eww6RRnwhsHoknPWC3j5JN4Xwcn7SXP/DMvRXipaXub4QPDbrZJU+SiV9JbmzCeJssOytGOaoDa
 R1a72+1Yl2RCYzDE=
X-Received: by 2002:a05:6000:91:b0:320:67:5580 with SMTP id
 m17-20020a056000009100b0032000675580mr5184126wrx.5.1696523537701; 
 Thu, 05 Oct 2023 09:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZph6HBp7kFTa6pW94XtOAbBpr5WTs5GutCMzXtc/wZpbMH/ZZYY7zF/phJrzJFfkHcl3PKA==
X-Received: by 2002:a05:6000:91:b0:320:67:5580 with SMTP id
 m17-20020a056000009100b0032000675580mr5184115wrx.5.1696523537332; 
 Thu, 05 Oct 2023 09:32:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:cded:de7:6702:3b9d:235c])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a5d594f000000b0030ada01ca78sm2140030wri.10.2023.10.05.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 09:32:16 -0700 (PDT)
Date: Thu, 5 Oct 2023 12:32:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Jonathan.Cameron@huawei.com, imammedo@redhat.com,
 anisinha@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231005122736-mutt-send-email-mst@kernel.org>
References: <20231004180529-mutt-send-email-mst@kernel.org>
 <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
 <20231004230132-mutt-send-email-mst@kernel.org>
 <12874c03-7de0-474f-9378-7d3ab8572d8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12874c03-7de0-474f-9378-7d3ab8572d8d@intel.com>
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

On Thu, Oct 05, 2023 at 09:11:15AM -0700, Dave Jiang wrote:
> 
> 
> On 10/4/23 20:36, Michael S. Tsirkin wrote:
> > 
> > On Wed, Oct 04, 2023 at 04:09:07PM -0700, Dave Jiang wrote:
> >> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> >> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> >> from the OS.
> > 
> > 
> > the enabling -> this
> 
> will update
> > 
> >>
> >> Following edited for readbility only
> > 
> > readbility only -> readability
> 
> will update
> > 
> > 
> >>
> >> Device (CXLM)
> >> {
> >>     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> >> ...
> >>     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> >>     {
> >>         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
> >>         {
> >>             If ((Arg2 == Zero))
> >>             {
> >>                 Return (Buffer (One) { 0x01 })
> >>             }
> >>
> >>             If ((Arg2 == One))
> > 
> >>             {
> >>                 Return (Package (0x02)
> >>                 {
> >>                     Buffer (0x02)
> >>                     { 0x01, 0x00 },
> >>                     Package (0x01)
> >>                     {
> >>                         Buffer (0x02)
> >>                         { 0x00, 0x00 }
> >>                     }
> >>                 })
> >>             }
> >>         }
> >>     }
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >> --
> >> v3: Fix output assignment to be BE host friendly. Fix typo in comment.
> >> According to the CXL spec, the DSM output should be 1 WORD to indicate
> >> the max suppoted QTG ID and a package of 0 or more WORDs for the QTG IDs.
> >> In this dummy impementation, we have first WORD with a 1 to indcate max
> >> supprted QTG ID of 1. And second WORD in a package to indicate the QTG
> >> ID of 0.
> >>
> >> v2: Minor edit to drop reference to switches in patch description.
> >> Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >>  hw/acpi/cxl.c         |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  hw/i386/acpi-build.c  |    1 +
> >>  include/hw/acpi/cxl.h |    1 +
> >>  3 files changed, 57 insertions(+)
> >>
> >> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> >> index 92b46bc9323b..cce12d5bc81c 100644
> >> --- a/hw/acpi/cxl.c
> >> +++ b/hw/acpi/cxl.c
> >> @@ -30,6 +30,61 @@
> >>  #include "qapi/error.h"
> >>  #include "qemu/uuid.h"
> >>  
> >> +void build_cxl_dsm_method(Aml *dev)
> >> +{
> >> +    Aml *method, *ifctx, *ifctx2;
> >> +
> >> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> >> +    {
> >> +        Aml *function, *uuid;
> >> +
> >> +        uuid = aml_arg(0);
> >> +        function = aml_arg(2);
> >> +        /* CXL spec v3.0 9.17.3.1 *
> > 
> > 
> > drop this * please
> > 
> >> , QTG ID _DSM
> 
> Ooops. git format-patch mangled this and I didn't catch. Will fix
> 
> > 
> > 
> > this is not the name of this paragraph. pls make it match
> > exactly so people can search
> > 
> >> */
> >> +        ifctx = aml_if(aml_equal(
> >> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> >> +
> >> +        /* Function 0, standard DSM query function */
> >> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> >> +        {
> >> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> > 
> > function 1?
> 
> Yes, will fix
> 
> > 
> >> +
> >> +            aml_append(ifctx2,
> >> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> >> +        }
> >> +        aml_append(ifctx, ifctx2);
> >> +
> >> +        /*
> >> +         * Function 1
> >> +         * A return value of {1, {0}} indicates that
> >> +         * max supported QTG ID of 1 and recommended QTG is 0.
> >> +         * The values here are faked to simplify emulation.
> > 
> > again pls quote spec directly do not paraphrase
> 
> Here it's not paraphrasing from the spec. I'm just describing the dummy value that will be provided.
> 
> > 
> >> +         */
> >> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> >> +        {
> >> +            uint16_t word_list = cpu_to_le16(1);
> >> +            uint16_t word_list2 = 0;
> >> +            Aml *pak, *pak1;
> >> +
> >> +            /*
> >> +             * The return package is a package of a WORD
> >> and another package.
> >> +             * The embedded package contains 0 or more WORDs for the
> >> +             * recommended QTG IDs.
> > 
> > 
> > 
> > pls quote the spec directly
> 
> Will do.
> 
> > 
> > what does "a WORD" mean is unclear - do you match what hardware does
> > when you use aml_buffer? pls mention this in commit log, and
> > show actual hardware dump for comparison.
> The CXL spec says WORD without much qualification. It's a 16bit value AFAICT. I'll add additional comment. Currently I do not have access to actual hardware unfortunately. I'm constructing this purely based on spec description.

It's not clear buffer is actually word though.

Jonathan do you have hardware access?

Also, possible to get clarification from the spec committee?

> 
> > 
> > 
> >> +             */
> >> +            pak1 = aml_package(1);
> >> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), word_list2));
> >> +            pak = aml_package(2);
> >> +            aml_append(pak, aml_buffer(sizeof(uint16_t), word_list));
> > 
> > 
> > It does not look like this patch compiles.
> > 
> > So how did you test it?
> > 
> > Please do not post untested patches.
> > 
> > If you do at least minimal testing
> > you would also see failures in bios table test
> > and would follow the procedure described there to
> > post it.
> 
> Sorry about that. I compiled successfully but did not test.

I don't see how it can compile either. In fact I just applied and build
fails.

> The following chunk is tested. However, is it the correct way to do this? The comment is direct spec verbiage. I'm not familiar with constructing ACPI tables in QEMU and tried my best by looking at other ACPI code in QEMU. 

To do what? create a buffer with a two byte word?
For example:
	word = aml_buffer(0, NULL);
	build_append_int_noprefix(word->buf, 2, 0x1);



but again it is not clear at all what does spec mean.
an integer up to 0xfffff? a buffer as you did? just two bytes?

could be any of these.

> 
> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> +        {
> +            uint16_t max_id = cpu_to_le16(1);
> +            uint16_t qtg_id = 0;
> +            Aml *pak, *pak1;
> +
> +            /*
> +            * Return: A package containing two elements - a WORD that returns
> +            * the maximum throttling group that the platform supports, and a
> +            * package containing the QTG ID(s) that the platform recommends.
> +            * Package {
> +            *     Max Supported QTG ID
> +            *     Package {QTG Recommendations}
> +            * }
> +            */
> +            pak1 = aml_package(1);
> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), (uint8_t *)&qtg_id));
> +            pak = aml_package(2);
> +            aml_append(pak, aml_buffer(sizeof(uint16_t), (uint8_t *)&max_id));
> +            aml_append(pak, pak1);
> +
> +            aml_append(ifctx2, aml_return(pak));
> +        }
> 
> 
> > 
> > 
> > When you post next version please also document how the patch
> > was tested: which guests, what tests, what were the results.
> > 
> > thanks!
> > 
> >> +            aml_append(pak, pak1);
> >> +
> >> +            aml_append(ifctx2, aml_return(pak));
> >> +        }
> >> +        aml_append(ifctx, ifctx2);
> >> +    }
> >> +    aml_append(method, ifctx);
> >> +    aml_append(dev, method);
> >> +}
> >> +
> >>  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
> >>  {
> >>      PXBDev *pxb = PXB_DEV(cxl);
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 95199c89008a..692af40b1a75 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
> >>      method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> >>      aml_append(method, aml_return(aml_int(0x01)));
> >>      aml_append(dev, method);
> >> +    build_cxl_dsm_method(dev);
> >>  
> >>      aml_append(scope, dev);
> >>      aml_append(table, scope);
> >> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> >> index acf441888683..8f22c71530d8 100644
> >> --- a/include/hw/acpi/cxl.h
> >> +++ b/include/hw/acpi/cxl.h
> >> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >>                      BIOSLinker *linker, const char *oem_id,
> >>                      const char *oem_table_id, CXLState *cxl_state);
> >>  void build_cxl_osc_method(Aml *dev);
> >> +void build_cxl_dsm_method(Aml *dev);
> >>  
> >>  #endif
> >>
> > 


