Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898EB7CB68E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsW3G-00089k-L1; Mon, 16 Oct 2023 18:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lokesh.jaliminche@gmail.com>)
 id 1qsW3E-00089X-TG; Mon, 16 Oct 2023 18:27:04 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lokesh.jaliminche@gmail.com>)
 id 1qsW3C-0003bQ-IG; Mon, 16 Oct 2023 18:27:04 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-65af7d102b3so33182626d6.1; 
 Mon, 16 Oct 2023 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697495221; x=1698100021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZldOQ2OSXKAI+VJtfqNv20viTBYn++jH86a6nr7RhYY=;
 b=bwjPrAhn0hzjAJyBlouYcrEvqnlYfUKNUhMnFISDXLx6dyVLUdAMDr7/s6+BvgQpVs
 qqaYsS8oK+bTcCsqoLB3xRZXl91JRVyOYHmK4ZDsr5LAWOCqa/ixD7NayrhoW6I+21/z
 lgcF/ASQ1I/Px+1VPXnB4NPVTP9/fH/0KS0YVNWpDBz+eaRQGg6/9aI5k09PgbCScC9c
 GXI1OHOjlzspU2hfKsiuF8YfcJUe+c7RSc07Jny0opheYYJDPmOO/oimD4YH9HEadJix
 FeR0aWZtAqNNE+5fNY0uRYfO6MGSLVbDq66HfTi51d+/JATxVmZOf0Uk01au2oFR2u5s
 g1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495221; x=1698100021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZldOQ2OSXKAI+VJtfqNv20viTBYn++jH86a6nr7RhYY=;
 b=JhlkXBi5FleubzW92VZSwTdOOJoGJFPcQf+ePiZRdZXNcRt+kfZSqwLpydaSOksQaX
 gLZYV76Gotf7IUWXivtDt3hlIsv1OiZ9GVuQQ+WJudIEmUYf+Q4sULRUgwKKE4Yinlib
 +XCikyK797jIC4tTXm4Yq+BPcipwHVXhPpVATGmTILH/g/mYqmSCy/Uu37pDJMtZcVJ+
 c4f3tVCwqvQf8HTjJETuTLiBk5LbY1SBBKqUpce/OAZRrbXmTw8KLoQI5lEVvqnq4+AE
 Wnmq51x2X5Kgx0fg6xACmq6IadySqVGS1K+EvFVL5SOA8mRHoBGkeZkUru5w98mmXS/c
 XYWw==
X-Gm-Message-State: AOJu0YyFzNakNvYRMRFBQspZDjCaOhlkLgjRV25+M09NAOT/2qcHXHDw
 6+RHc81thbojN8pdayL2tVvzAud3aRv7QF2K/R4=
X-Google-Smtp-Source: AGHT+IF573BEWyr9EcWjtxLyS6MwriARHcu5A/aKAWD+ek45WkO6A9z8th5kPtCZNHUCz8Z423ViDuVOmX7aCqGuW5M=
X-Received: by 2002:a05:6214:2262:b0:66d:253c:9a80 with SMTP id
 gs2-20020a056214226200b0066d253c9a80mr1010949qvb.54.1697495220764; Mon, 16
 Oct 2023 15:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAKJOkCoxLG01Dt7xMjOPWRqhyLPuaNGRUaDn-sgAFfhERtAYJA@mail.gmail.com>
 <20231016105538.00000de5@Huawei.com>
In-Reply-To: <20231016105538.00000de5@Huawei.com>
From: lokesh jaliminche <lokesh.jaliminche@gmail.com>
Date: Mon, 16 Oct 2023 15:26:51 -0700
Message-ID: <CAKJOkCqk-HnzNXMmFxUe8UySqpgdAMLyLM_ciHEoMtvBFKFpNw@mail.gmail.com>
Subject: Re: Performance Issue with CXL-emulation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel-request@nongnu.org, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a4447c0607dce766"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=lokesh.jaliminche@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a4447c0607dce766
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for your quick and detailed response. I'll explore these options
further and asses if I get any performance uptick.

Thanks & Regards,
Lokesh

On Mon, Oct 16, 2023 at 2:56=E2=80=AFAM Jonathan Cameron <
Jonathan.Cameron@huawei.com> wrote:

> On Sun, 15 Oct 2023 10:39:46 -0700
> lokesh jaliminche <lokesh.jaliminche@gmail.com> wrote:
>
> > Hi Everyone,
> >
> > I am facing performance issues while copying data to the CXL device
> > (Emulated with QEMU). I get approximately 500KB/Sec. Any suggestion on
> how
> > to improve this?
>
> Hi Lokesh,
>
> The target so far of QEMU emulation of CXL devices has been on
> functionality.
> I'm in favour of work to improve on that, but it isn't likely to be my
> focus
> - can offer some pointers on where to look though!
>
> The fundamental problem (probably) is address decoding in CXL for
> interleaving
> is at a sub page granularity. That means we can't use page table to
> perform the address
> look ups in hardware. Note this also has the side effect that kvm won't
> work if
> there is any chance that you will run instructions out of the CXL memory =
-
> it's
> fine if you are interested in data only (DAX etc). (I've had a note in my
> todo list
> to add a warning message about the KVM limitations for a while).
>
> There have been a few discussions (mostly when we were debugging some TCG
> issues
> and considering KVM support) about how we 'might' be able to improve
> this.  That focused
> on a general 'fix', but there may be some lower hanging fruit.
>
> The options I think might work are:
>
> 1) Special case configurations where there is no interleave going on.
>    I'm not entirely sure how this would fit together and it won't deal
> with the
>    more interesting cases - if it does work I'd want it to be minimally
> invasive because
>    those complex cases are the main focus of testing etc.  There is an
> extension of this
>    where we handle interleave, but only if it is 4k or above (on
> appropriately configured
>    host).
>
> 2) Add caching layer to the CXL fixed memory windows.  That would hold
> copies of a
>    number of pages that have been accessed in a software cache and setup
> the mappings for
>    the hardware page table walkers to find them. If the page isn't cached
> we'd trigger
>    a pagefault and have to bring it into the cache. If the configuration
> of the interleave
>    is touched, all caches would need to be written back etc. This would
> need to be optional
>    because I don't want to have to add cache coherency protocols etc when
> we add shared
>    memory support (fun though it would be ;)
>
> 3) Might be worth looking at the critical paths for lookups in your
> configuration.
>    Maybe we can optimize the address decoders (basically a software TLB
> for HPA to DPA).
>    I've not looked at the performance of those paths.  For your example
> the lookup is
>    * CFMWS - nothing to do
>    * Host bridge - nothing to do beyond a sanity check on range I think.
>    * Nothing to to do.
>    * Type 3 device - basic range match.
>    So I'm not sure it is worth while - but you could do a really simple
> test by detecting
>    no interleave is going on and caching the offset needed to go HPA to
> DPA + a device reference
>    for the first time cxl_cfmws_find_device() is called.
>    https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-host.c#L129
>
>
>    Then just match on hwaddr on another call of cxl_cmws_find_device() an=
d
> return the device
>    directly.  Maybe also shortcut lookups in cxl_type3_hpa_to_as_and_dpa(=
)
> which does the endpoint
>    decoding part. A quick hack would let you know if it was worth looking
> at something more general.
>
>    Gut feeling is this last approach might get you some perf uptick but
> not going to solve
>    the fundamental problem that in general we can't do the translation in
> hardware (unlike most
>    other memory accesses in QEMU).
>
>    Not I believe all writes to file backed memory will go all the way to
> the file. So you might want
>    to try backing it with RAM but I as with the above, that's not going t=
o
> address the fundamental
>    problem.
>
>
> Jonathan
>
>
>
>
> >
> > Steps to reproduce :
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. QEMU Command:
> > sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \
> > -hda ./images/ubuntu-22.04-server-cloudimg-amd64.img \
> > -hdb ./images/user-data.img \
> > -M q35,cxl=3Don,accel=3Dkvm,nvdimm=3Don \
> > -smp 16 \
> > -m 16G,maxmem=3D32G,slots=3D8 \
> > -object
> >
> memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/mnt/qemu_files/c=
xltest.raw,size=3D256M
> > \
> > -object
> >
> memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/mnt/qemu_files/l=
sa.raw,size=3D256M
> > \
> > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> > -device
> >
> cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,i=
d=3Dcxl-pmem0
> > \
> > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \
> > -nographic \
> >
> > 2. Configure device with fsdax mode
> > ubuntu@ubuntu:~$ cxl list
> > [
> >   {
> >     "memdevs":[
> >       {
> >         "memdev":"mem0",
> >         "pmem_size":268435456,
> >         "serial":0,
> >         "host":"0000:0d:00.0"
> >       }
> >     ]
> >   },
> >   {
> >     "regions":[
> >       {
> >         "region":"region0",
> >         "resource":45365592064,
> >         "size":268435456,
> >         "type":"pmem",
> >         "interleave_ways":1,
> >         "interleave_granularity":1024,
> >         "decode_state":"commit"
> >       }
> >     ]
> >   }
> > ]
> >
> > 3. Format the device with ext4 file system in dax mode
> >
> > 4. Write data to mounted device with dd
> >
> > ubuntu@ubuntu:~$ time sudo dd if=3D/dev/urandom
> > of=3D/home/ubuntu/mnt/pmem0/test bs=3D1M count=3D128
> > 128+0 records in
> > 128+0 records out
> > 134217728 bytes (134 MB, 128 MiB) copied, 244.802 s, 548 kB/s
> >
> > real    4m4.850s
> > user    0m0.014s
> > sys     0m0.013s
> >
> >
> > Thanks & Regards,
> > Lokesh
> >
>
>

--000000000000a4447c0607dce766
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>Thanks for your quick and =
detailed response.=C2=A0I&#39;ll explore these options further and asses if=
 I get any performance uptick.</div><div><br></div><div>Thanks &amp; Regard=
s,<br>Lokesh</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Mon, Oct 16, 2023 at 2:56=E2=80=AFAM Jonathan Cameron =
&lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com">Jonathan.Cameron@huawei.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Sun, 15 Oct 2023 10:39:46 -0700<br>
lokesh jaliminche &lt;<a href=3D"mailto:lokesh.jaliminche@gmail.com" target=
=3D"_blank">lokesh.jaliminche@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hi Everyone,<br>
&gt; <br>
&gt; I am facing performance issues while copying data to the CXL device<br=
>
&gt; (Emulated with QEMU). I get approximately 500KB/Sec. Any suggestion on=
 how<br>
&gt; to improve this?<br>
<br>
Hi Lokesh,<br>
<br>
The target so far of QEMU emulation of CXL devices has been on functionalit=
y.<br>
I&#39;m in favour of work to improve on that, but it isn&#39;t likely to be=
 my focus<br>
- can offer some pointers on where to look though!<br>
<br>
The fundamental problem (probably) is address decoding in CXL for interleav=
ing<br>
is at a sub page granularity. That means we can&#39;t use page table to per=
form the address<br>
look ups in hardware. Note this also has the side effect that kvm won&#39;t=
 work if<br>
there is any chance that you will run instructions out of the CXL memory - =
it&#39;s<br>
fine if you are interested in data only (DAX etc). (I&#39;ve had a note in =
my todo list<br>
to add a warning message about the KVM limitations for a while).<br>
<br>
There have been a few discussions (mostly when we were debugging some TCG i=
ssues<br>
and considering KVM support) about how we &#39;might&#39; be able to improv=
e this.=C2=A0 That focused<br>
on a general &#39;fix&#39;, but there may be some lower hanging fruit.<br>
<br>
The options I think might work are:<br>
<br>
1) Special case configurations where there is no interleave going on.<br>
=C2=A0 =C2=A0I&#39;m not entirely sure how this would fit together and it w=
on&#39;t deal with the<br>
=C2=A0 =C2=A0more interesting cases - if it does work I&#39;d want it to be=
 minimally invasive because<br>
=C2=A0 =C2=A0those complex cases are the main focus of testing etc.=C2=A0 T=
here is an extension of this<br>
=C2=A0 =C2=A0where we handle interleave, but only if it is 4k or above (on =
appropriately configured<br>
=C2=A0 =C2=A0host).<br>
<br>
2) Add caching layer to the CXL fixed memory windows.=C2=A0 That would hold=
 copies of a<br>
=C2=A0 =C2=A0number of pages that have been accessed in a software cache an=
d setup the mappings for<br>
=C2=A0 =C2=A0the hardware page table walkers to find them. If the page isn&=
#39;t cached we&#39;d trigger<br>
=C2=A0 =C2=A0a pagefault and have to bring it into the cache. If the config=
uration of the interleave<br>
=C2=A0 =C2=A0is touched, all caches would need to be written back etc. This=
 would need to be optional<br>
=C2=A0 =C2=A0because I don&#39;t want to have to add cache coherency protoc=
ols etc when we add shared<br>
=C2=A0 =C2=A0memory support (fun though it would be ;) <br>
<br>
3) Might be worth looking at the critical paths for lookups in your configu=
ration.<br>
=C2=A0 =C2=A0Maybe we can optimize the address decoders (basically a softwa=
re TLB for HPA to DPA).<br>
=C2=A0 =C2=A0I&#39;ve not looked at the performance of those paths.=C2=A0 F=
or your example the lookup is<br>
=C2=A0 =C2=A0* CFMWS - nothing to do<br>
=C2=A0 =C2=A0* Host bridge - nothing to do beyond a sanity check on range I=
 think.<br>
=C2=A0 =C2=A0* Nothing to to do.<br>
=C2=A0 =C2=A0* Type 3 device - basic range match.<br>
=C2=A0 =C2=A0So I&#39;m not sure it is worth while - but you could do a rea=
lly simple test by detecting<br>
=C2=A0 =C2=A0no interleave is going on and caching the offset needed to go =
HPA to DPA + a device reference<br>
=C2=A0 =C2=A0for the first time cxl_cfmws_find_device() is called. <br>
=C2=A0 =C2=A0<a href=3D"https://elixir.bootlin.com/qemu/latest/source/hw/cx=
l/cxl-host.c#L129" rel=3D"noreferrer" target=3D"_blank">https://elixir.boot=
lin.com/qemu/latest/source/hw/cxl/cxl-host.c#L129</a><br>
<br>
<br>
=C2=A0 =C2=A0Then just match on hwaddr on another call of cxl_cmws_find_dev=
ice() and return the device<br>
=C2=A0 =C2=A0directly.=C2=A0 Maybe also shortcut lookups in cxl_type3_hpa_t=
o_as_and_dpa() which does the endpoint<br>
=C2=A0 =C2=A0decoding part. A quick hack would let you know if it was worth=
 looking at something more general.<br>
<br>
=C2=A0 =C2=A0Gut feeling is this last approach might get you some perf upti=
ck but not going to solve<br>
=C2=A0 =C2=A0the fundamental problem that in general we can&#39;t do the tr=
anslation in hardware (unlike most<br>
=C2=A0 =C2=A0other memory accesses in QEMU).<br>
<br>
=C2=A0 =C2=A0Not I believe all writes to file backed memory will go all the=
 way to the file. So you might want<br>
=C2=A0 =C2=A0to try backing it with RAM but I as with the above, that&#39;s=
 not going to address the fundamental<br>
=C2=A0 =C2=A0problem.<br>
<br>
<br>
Jonathan<br>
<br>
<br>
<br>
<br>
&gt; <br>
&gt; Steps to reproduce :<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; 1. QEMU Command:<br>
&gt; sudo /opt/qemu-cxl/bin/qemu-system-x86_64 \<br>
&gt; -hda ./images/ubuntu-22.04-server-cloudimg-amd64.img \<br>
&gt; -hdb ./images/user-data.img \<br>
&gt; -M q35,cxl=3Don,accel=3Dkvm,nvdimm=3Don \<br>
&gt; -smp 16 \<br>
&gt; -m 16G,maxmem=3D32G,slots=3D8 \<br>
&gt; -object<br>
&gt; memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=3D/mnt/qemu_file=
s/cxltest.raw,size=3D256M<br>
&gt; \<br>
&gt; -object<br>
&gt; memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/mnt/qemu_file=
s/lsa.raw,size=3D256M<br>
&gt; \<br>
&gt; -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \<br>
&gt; -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \<br>
&gt; -device<br>
&gt; cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1,lsa=3Dcxl-lsa=
1,id=3Dcxl-pmem0<br>
&gt; \<br>
&gt; -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G \<br>
&gt; -nographic \<br>
&gt; <br>
&gt; 2. Configure device with fsdax mode<br>
&gt; ubuntu@ubuntu:~$ cxl list<br>
&gt; [<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;memdevs&quot;:[<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;memdev&quot;:&quot;mem0&quot;,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pmem_size&quot;:268435456,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;serial&quot;:0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;host&quot;:&quot;0000:0d:00.0&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;regions&quot;:[<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;region&quot;:&quot;region0&quot=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;resource&quot;:45365592064,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;size&quot;:268435456,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;type&quot;:&quot;pmem&quot;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;interleave_ways&quot;:1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;interleave_granularity&quot;:10=
24,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;decode_state&quot;:&quot;commit=
&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; ]<br>
&gt; <br>
&gt; 3. Format the device with ext4 file system in dax mode<br>
&gt; <br>
&gt; 4. Write data to mounted device with dd<br>
&gt; <br>
&gt; ubuntu@ubuntu:~$ time sudo dd if=3D/dev/urandom<br>
&gt; of=3D/home/ubuntu/mnt/pmem0/test bs=3D1M count=3D128<br>
&gt; 128+0 records in<br>
&gt; 128+0 records out<br>
&gt; 134217728 bytes (134 MB, 128 MiB) copied, 244.802 s, 548 kB/s<br>
&gt; <br>
&gt; real=C2=A0 =C2=A0 4m4.850s<br>
&gt; user=C2=A0 =C2=A0 0m0.014s<br>
&gt; sys=C2=A0 =C2=A0 =C2=A00m0.013s<br>
&gt; <br>
&gt; <br>
&gt; Thanks &amp; Regards,<br>
&gt; Lokesh<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000a4447c0607dce766--

