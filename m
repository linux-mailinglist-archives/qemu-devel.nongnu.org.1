Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13267BC9EC
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 23:19:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpEgX-00029E-M8; Sat, 07 Oct 2023 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpEgT-000292-FS
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 17:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpEgO-0006zU-1D
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 17:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696713473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgFH0Bv6V3ZloxVFH3bRC9aukIkzcvNktBvNlx+o/Uc=;
 b=DXbh8tsBLPeoiH+7F3/9pI2pBzhsUd9gINCM5jUzFB6w5H0FlnFyvJ8LDnEEdMfrNyWpoT
 xf4OwPLfVkvmaZz6tCkO8nPWKpoWW0EwNCH4CUe+1DWNKzqYHprY8RhT/OnBCQnAzVH2XX
 lwkuVNQTGO7kais5blbOrLsJYC1vifg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-YF4DLPX2ND2CPOz4NMknZA-1; Sat, 07 Oct 2023 17:17:51 -0400
X-MC-Unique: YF4DLPX2ND2CPOz4NMknZA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-533c6d0b377so2795732a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 14:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696713470; x=1697318270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgFH0Bv6V3ZloxVFH3bRC9aukIkzcvNktBvNlx+o/Uc=;
 b=Sx72/c4fD9obMgAbtvviGVzF07uDLIFg18FyQ5C0OTGsGecDErFbVW7VGJFaq4aUb9
 V3TRAXYFqMfMdfdxqzUDku8jCy81CMInOApWXqFD2ZnfsgkPjpJ/yG8pJwpWQhHJlBB7
 MDRD2/PxkKU8fo04TdSXHVuk6xqDD8A6WUJgg37f2qSNO+uLKdMXKBVXV8oYF5UNgugY
 J7C+1XKcZrns4O0AznUSjn4K4Vriehz4Q8RheZGmACgMF9vlO6S6VMTADKeQXWBR14YU
 6I1C/oPERP0QeI3Tb5aLfXG5lSwn6rNN0R2a7rzRtYHrP8FAfaF0+HpQuAvp58nHQJ/n
 Nr4Q==
X-Gm-Message-State: AOJu0YzHQ9c05yNvX3Rl/ZXnXCXKyLPCR5s1SO+bJ5mG1T2rK3OGDQ9U
 1PB//kztvL9+DMUqAbj1iRHNX/SY5+KHDmCmTxlFmE35PfuGGCNE2OU03xDljtt6ChSmsJKo/mc
 TFe2p6tQkXg8VBCk=
X-Received: by 2002:aa7:de03:0:b0:52c:84c4:a0bf with SMTP id
 h3-20020aa7de03000000b0052c84c4a0bfmr10934287edv.30.1696713470685; 
 Sat, 07 Oct 2023 14:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlJ2PKpC8Chb4JIKE0p+pEClbTX8POBvy5a9c9CzvT/ABRaePpenKFW8ydV86oe972kkSfrQ==
X-Received: by 2002:aa7:de03:0:b0:52c:84c4:a0bf with SMTP id
 h3-20020aa7de03000000b0052c84c4a0bfmr10934266edv.30.1696713470140; 
 Sat, 07 Oct 2023 14:17:50 -0700 (PDT)
Received: from redhat.com ([2.55.10.88]) by smtp.gmail.com with ESMTPSA id
 bm15-20020a0564020b0f00b005346925a474sm4288851edb.43.2023.10.07.14.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 14:17:49 -0700 (PDT)
Date: Sat, 7 Oct 2023 17:17:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, thuth@redhat.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231007170145-mutt-send-email-mst@kernel.org>
References: <20231004180529-mutt-send-email-mst@kernel.org>
 <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
 <20231004230132-mutt-send-email-mst@kernel.org>
 <12874c03-7de0-474f-9378-7d3ab8572d8d@intel.com>
 <20231005122736-mutt-send-email-mst@kernel.org>
 <20231006130939.00007a69@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006130939.00007a69@Huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 06, 2023 at 01:09:39PM +0100, Jonathan Cameron wrote:
> On Thu, 5 Oct 2023 12:32:11 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 05, 2023 at 09:11:15AM -0700, Dave Jiang wrote:
> > > 
> > > 
> > > On 10/4/23 20:36, Michael S. Tsirkin wrote:  
> > > > 
> > > > On Wed, Oct 04, 2023 at 04:09:07PM -0700, Dave Jiang wrote:  
> > > >> Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> > > >> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> > > >> from the OS.  
> > > > 
> > > > 
> > > > the enabling -> this  
> > > 
> > > will update  
> > > >   
> > > >>
> > > >> Following edited for readbility only  
> > > > 
> > > > readbility only -> readability  
> > > 
> > > will update  
> > > > 
> > > >   
> > > >>
> > > >> Device (CXLM)
> > > >> {
> > > >>     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> > > >> ...
> > > >>     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> > > >>     {
> > > >>         If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
> > > >>         {
> > > >>             If ((Arg2 == Zero))
> > > >>             {
> > > >>                 Return (Buffer (One) { 0x01 })
> > > >>             }
> > > >>
> > > >>             If ((Arg2 == One))  
> > > >   
> > > >>             {
> > > >>                 Return (Package (0x02)
> > > >>                 {
> > > >>                     Buffer (0x02)
> > > >>                     { 0x01, 0x00 },
> > > >>                     Package (0x01)
> > > >>                     {
> > > >>                         Buffer (0x02)
> > > >>                         { 0x00, 0x00 }
> > > >>                     }
> > > >>                 })
> > > >>             }
> > > >>         }
> > > >>     }
> > > >>
> > > >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >>
> > > >> --
> > > >> v3: Fix output assignment to be BE host friendly. Fix typo in comment.
> > > >> According to the CXL spec, the DSM output should be 1 WORD to indicate
> > > >> the max suppoted QTG ID and a package of 0 or more WORDs for the QTG IDs.
> > > >> In this dummy impementation, we have first WORD with a 1 to indcate max
> > > >> supprted QTG ID of 1. And second WORD in a package to indicate the QTG
> > > >> ID of 0.
> > > >>
> > > >> v2: Minor edit to drop reference to switches in patch description.
> > > >> Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
> > > >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >> ---
> > > >>  hw/acpi/cxl.c         |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >>  hw/i386/acpi-build.c  |    1 +
> > > >>  include/hw/acpi/cxl.h |    1 +
> > > >>  3 files changed, 57 insertions(+)
> > > >>
> > > >> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> > > >> index 92b46bc9323b..cce12d5bc81c 100644
> > > >> --- a/hw/acpi/cxl.c
> > > >> +++ b/hw/acpi/cxl.c
> > > >> @@ -30,6 +30,61 @@
> > > >>  #include "qapi/error.h"
> > > >>  #include "qemu/uuid.h"
> > > >>  
> > > >> +void build_cxl_dsm_method(Aml *dev)
> > > >> +{
> > > >> +    Aml *method, *ifctx, *ifctx2;
> > > >> +
> > > >> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> > > >> +    {
> > > >> +        Aml *function, *uuid;
> > > >> +
> > > >> +        uuid = aml_arg(0);
> > > >> +        function = aml_arg(2);
> > > >> +        /* CXL spec v3.0 9.17.3.1 *  
> > > > 
> > > > 
> > > > drop this * please
> > > >   
> > > >> , QTG ID _DSM  
> > > 
> > > Ooops. git format-patch mangled this and I didn't catch. Will fix
> > >   
> > > > 
> > > > 
> > > > this is not the name of this paragraph. pls make it match
> > > > exactly so people can search
> > > >   
> > > >> */
> > > >> +        ifctx = aml_if(aml_equal(
> > > >> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> > > >> +
> > > >> +        /* Function 0, standard DSM query function */
> > > >> +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> > > >> +        {
> > > >> +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */  
> > > > 
> > > > function 1?  
> > > 
> > > Yes, will fix
> > >   
> > > >   
> > > >> +
> > > >> +            aml_append(ifctx2,
> > > >> +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> > > >> +        }
> > > >> +        aml_append(ifctx, ifctx2);
> > > >> +
> > > >> +        /*
> > > >> +         * Function 1
> > > >> +         * A return value of {1, {0}} indicates that
> > > >> +         * max supported QTG ID of 1 and recommended QTG is 0.
> > > >> +         * The values here are faked to simplify emulation.  
> > > > 
> > > > again pls quote spec directly do not paraphrase  
> > > 
> > > Here it's not paraphrasing from the spec. I'm just describing the dummy value that will be provided.
> > >   
> > > >   
> > > >> +         */
> > > >> +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> > > >> +        {
> > > >> +            uint16_t word_list = cpu_to_le16(1);
> > > >> +            uint16_t word_list2 = 0;
> > > >> +            Aml *pak, *pak1;
> > > >> +
> > > >> +            /*
> > > >> +             * The return package is a package of a WORD
> > > >> and another package.
> > > >> +             * The embedded package contains 0 or more WORDs for the
> > > >> +             * recommended QTG IDs.  
> > > > 
> > > > 
> > > > 
> > > > pls quote the spec directly  
> > > 
> > > Will do.
> > >   
> > > > 
> > > > what does "a WORD" mean is unclear - do you match what hardware does
> > > > when you use aml_buffer? pls mention this in commit log, and
> > > > show actual hardware dump for comparison.  
> > > The CXL spec says WORD without much qualification. It's a 16bit value AFAICT. I'll add additional comment. Currently I do not have access to actual hardware unfortunately. I'm constructing this purely based on spec description.  
> > 
> 
> WORD does seem to be clearly defined in the ACPI spec as uint16
> and as this is describing a DSDT blob I think we can safe that
> it means that.  Also lines up with the fixed sizes in CEDT.

Binary blobs are not really legal as return values of AML though.
What this patch was doing was a buffer. An alternative
interpretation would be an integer. Or something else yet ...


> > It's not clear buffer is actually word though.
> > 
> > Jonathan do you have hardware access?
> 
> No.  +CC linux-cxl to see if anyone else has hardware + BIOS with
> QTG implemented...  There will be lots of implementations soon so I'd make
> not guarantee they will all interpret this the same.
> 
> Aim here is Linux kernel enablement support, and unfortunately that almost
> always means we are ahead of easy availability of hardware. If it exists
> its probably prototypes in a lab, in which case no guarantees on the
> BIOS tables presented...
> 
> > 
> > Also, possible to get clarification from the spec committee?
> 
> I'm unclear what we are clarifying.

Let me clarify, below.

>  As I read it current implementation
> is indeed wrong and I failed to notice this earlier :(
> 
> Ultimately data encoding (ACPI 6.5 section 20.2..3 Data Objects Encoding)
> should I think be
> 
> 0x0B 0x00 0x00
> WordPrefix then data : note if you try a 0x0001 and feed
> it to iasl it will squash it into a byte instead and indeed if you
> force the binary to the above it will decode it as 0x0000 but recompile
> that and you will be back to just
> 0x00 (as bytes don't need a prefix..)

Exactly. So this is the clarification we seek. ACPI spec
does mention WordPrefix however only as one of the
ways to encode an integer, as part of ComputationalData,
never directly. If CXL requires it to be WordPrefix then
qemu can do it but tools such as IASL will need to be taught a way
to force using WordPrefix.


> Currently it would be.
> 0x11     0x05 0x0a 0x02 0x00 0x01
> BufferOp 
> 
> Btw I built a minimal DSDT file to test this and iasl isn't happy with
> the fact the _DSM doesn't return anything at all if ARG2 isn't 1 or 2.
> Whilst that's imdef territory as not covered by the CXL spec, we should
> return 'something' ;)
> 
> Anyhow, to do this as per the CXL spec we need an aml_word()
> that just implements the word case from aml_int()
> 
> Chance are that it never matters if we get an ecoding that is
> only single byte (because the value is small) but who knows what
> other AML parsers might do.
> 
> Something simple like (copy typed from test machine..)
> 
> Aml *aml_word(const uint16_t val)
> {
>     Aml *var = aml_alloc();
>     build_append_byte(var->buf, 0x0B);
>     build_append_int_noprefix(var->buf, val, 2);
>     return var;
> }
> 
> and one blob in acpi/cxl.c becomes
> 
>         ifctx2 = aml_if(aml_equal(function, aml_int(1)));
>         {
>              Aml *pak, *pac1;
> 
> 	     pak1 = aml_package(1)
> 	     aml_append(pak1, aml_word(0));
>              pak = aml_package(2);
>              aml_append(pack, aml_word(0x1));
>              aml_append(pak, pak1);
> 
>              aml_append(ifctx2, aml_return(pak));
>         }
>         aml_append(ifctx, ifctx2);
> ...
> 
>  
>         }
> 
> Give something like
> If ((Arg2 == One))
> {
>     Return (Package (0x02)
>     {
>         0x0001,
>         Package (0x01)
>         {
>             0x0000
>         }
>     })
> }
> 
> 
> Binary encoding then clearly uses packages of words.
> 
> 12      0b        02         0b    01 00     12    05    01        0b    00 00
> PkgOp   len       elements   word  0x0001    pkgOp len   elements  word  0x0000
> 
> (note I cheated an added a marker in one of the values and didn't decode
> the whole thing by hand ;)

We could. But I suspect it's a spec bug and they really just meant
"an integer in the range 0x0 to 0xffff, encoded in any legal way".


> > 
> > >   
> > > > 
> > > >   
> > > >> +             */
> > > >> +            pak1 = aml_package(1);
> > > >> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), word_list2));
> > > >> +            pak = aml_package(2);
> > > >> +            aml_append(pak, aml_buffer(sizeof(uint16_t), word_list));  
> > > > 
> > > > 
> > > > It does not look like this patch compiles.
> > > > 
> > > > So how did you test it?
> > > > 
> > > > Please do not post untested patches.
> > > > 
> > > > If you do at least minimal testing
> > > > you would also see failures in bios table test
> > > > and would follow the procedure described there to
> > > > post it.  
> > > 
> > > Sorry about that. I compiled successfully but did not test.  
> > 
> > I don't see how it can compile either. In fact I just applied and build
> > fails.
> > 
> > > The following chunk is tested. However, is it the correct way to do this? The comment is direct spec verbiage. I'm not familiar with constructing ACPI tables in QEMU and tried my best by looking at other ACPI code in QEMU.   
> > 
> > To do what? create a buffer with a two byte word?
> > For example:
> > 	word = aml_buffer(0, NULL);
> > 	build_append_int_noprefix(word->buf, 2, 0x1);
> > 
> > 
> > 
> > but again it is not clear at all what does spec mean.
> > an integer up to 0xfffff? a buffer as you did? just two bytes?
> > 
> > could be any of these.
> 
> The best we have in the way of description is the multiple QTG example
> where it's
> Package() {2, 1} combined with it being made up of WORDs
> 
> whereas in general that will get squashed to a pair of bytes...
> So I'm thinking WORDs is max size rather than only size but
> given ambiguity we should encode them as words anyway.

But why, is it suddenly important to be compatible with lots of drivers?
These are just dummy values after all.
If the point is for driver development then I would say just use
aml_int, this will test support for One and Zero opcodes :)

> Note this breaks Dave's current kernel proposal which is assuming
> a buffer...
> https://lore.kernel.org/all/168695172301.3031571.9812118774299137032.stgit@djiang5-mobl3/
> 
> Hohum. Dave, can you sanity check with the appropriate SSWG person (MN IIRC)
> I can do it you'd prefer - just let me know.
> 
> Jonathan
> 


