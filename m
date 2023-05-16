Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E231770432A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 03:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyju2-0001zi-Pa; Mon, 15 May 2023 21:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1pyjty-0001z5-HQ; Mon, 15 May 2023 21:55:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1pyjtv-00038b-Uy; Mon, 15 May 2023 21:54:58 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G1ploH030220; Tue, 16 May 2023 01:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=pp1; bh=KX8O9pTCC5ZbPUr5eGyiOWFrVv5JfDCM0rpYkbL/whM=;
 b=pJy3UFEAnA0PeHgtm9XHEl6ICyZPeYDe7bDVq2fObzzB+oWiiKhWldfHIkZnOLWr7oWT
 +wzKn3u5dhr2QUlMCTtwwoxHrmgDin0gW0infVlaghagnOG4taMFyZm+oRLxF/yQOMqx
 yPXIEB00O7z1tBoT1nkOr1VNtcL8lWUMGUipzXmB27hjDf5zM4aEGs8eHXEe14Wi8mcV
 dTip4VOFoS2VSEOMvpeNyni1sADaeZ3pkum8ggeWpYrfwhOJ8gUrp0fPBS3acr/aMD2L
 XLHsqayPH1ncnjpeMVK2XNBW9yuAxYhKVZMWh3nwzIzJF7j3Xbc3CL8JN9kHvLVCj6/6 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm0hur1xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 01:54:41 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34G1qHnR031928;
 Tue, 16 May 2023 01:54:41 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm0hur1wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 01:54:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G0ku4S005252;
 Tue, 16 May 2023 01:54:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdsbbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 May 2023 01:54:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34G1sZ3X41419156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 01:54:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17A1420043;
 Tue, 16 May 2023 01:54:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5112820040;
 Tue, 16 May 2023 01:54:30 +0000 (GMT)
Received: from [9.43.115.119] (unknown [9.43.115.119])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 May 2023 01:54:29 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ym03TX8EcgOZLs6w2sdva7in"
Message-ID: <814e7c18-39f4-505c-4072-7d580c99af63@linux.vnet.ibm.com>
Date: Tue, 16 May 2023 07:24:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target: ppc: Correctly initialize HILE in HID-0 for
 book3s processors
To: Nicholas Piggin <npiggin@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, danielhb413@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@linux.ibm.com,
 vajain21@linux.ibm.com, harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20230420145055.10196-1-nnmlinux@linux.ibm.com>
 <87v8hq8lgz.fsf@suse.de> <87y1mcfvzo.fsf@vajain21.in.ibm.com>
 <87sfckrsd9.fsf@suse.de> <CSMN30SCVNA1.DOF9IMJOJRM5@wheely>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.vnet.ibm.com>
In-Reply-To: <CSMN30SCVNA1.DOF9IMJOJRM5@wheely>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xwCLjsxynCm5yytbXBst83fn-obsoEFr
X-Proofpoint-ORIG-GUID: X85zkF6WDWX-Es9gfYl1mcHCRMZ5Tbm5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160011
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, NICE_REPLY_A=-3.811,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------ym03TX8EcgOZLs6w2sdva7in
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/15/23 12:02, Nicholas Piggin wrote:
> On Sat Apr 29, 2023 at 12:30 AM AEST, Fabiano Rosas wrote:
>> Vaibhav Jain<vaibhav@linux.ibm.com>  writes:
>>
>>> Hi Fabiano,
>>>
>>> Thanks for looking into this patch and apologies for the delayed reponse.
>>> Fabiano Rosas<farosas@suse.de>  writes:
>>>
>>>> Narayana Murty N<nnmlinux@linux.ibm.com>  writes:
>>>>
>>>>> On PPC64 the HILE(Hypervisor Interrupt Little Endian) bit in HID-0
>>>>> register needs to be initialized as per isa 3.0b[1] section
>>>>> 2.10. This bit gets copied to the MSR_LE when handling interrupts that
>>>>> are handled in HV mode to establish the Endianess mode of the interrupt
>>>>> handler.
>>>>>
>>>>> Qemu's ppc_interrupts_little_endian() depends on HILE to determine Host
>>>>> endianness which is then used to determine the endianess of the guest dump.
>>>>>
>>>> Not quite. We use the interrupt endianness as a proxy to guest
>>>> endianness to avoid reading MSR_LE at an inopportune moment when the
>>>> guest is switching endianness.
>>> Agreed
>>>
>>>> This is not dependent on host
>>>> endianness. The HILE check is used when taking a memory dump of a
>>>> HV-capable machine such as the emulated powernv.
>>> I think one concern which the patch tries to address is the guest memorydump file
>>> generated of a BigEndian(BE) guest on a LittleEndian(LE) host is not readable on
>>> the same LE host since 'crash' doesnt support cross endianess
>>> dumps. Also even for a LE guest on LE host the memory dumps are marked as BE
>>> making it not possible to analyze any guest memory dumps on the host.
>>>
>>  From QEMU's perspective there's no "host" in this equation. We'll
>> generate a BE dump for a BE guest and a LE dump for a LE guest. Anything
>> different is a bug in QEMU (as the one this patch addresses).
> I'm trying to figure out what's going on here. On one hand we are
> creating a dump for/in the host. The dump is just a format that
> describes register metadata, the same values can be represented just
> fine with either endian. Memory has no endianness (without data
> structures). So from that perspective, we do want to dump host endian
> format.
>
> OTOH crash could be taught foreign-endianness in which case the
> endianness of the ELF file could be useful metadata about the
> target I suppose. But ILE != MSR[LE] at any given time.
>
> ILE seems like a half way house. It doesn't always give host endian
> dumps so crash won't always work. It doesn't always give the machine
> operating mode either. So why is it better to take guest ILE mode than
> HV ILE mode?
>
> I guess the first thing we need is a better and precise description of
> the problem and the desired resolution. PPC64 has powernv and pseries,
> both of which can support guests in various ways (PR, HV, nested HV),
> and then when running guests the target itself also functions as a host,
> so need to make all that unambiguous and use correct terminoogy in
> the changelog.
>
>>> However setting the HILE based on host endianess of qemu might not be
>>> the right way to fix this problem. Based on an off mailing list discussion
>>> with Narayana, he is working on another patch which doesnt set HILE
>>> based on host endianess. However the problem seems to be stemming from
>>> fact that qemu on KVM is using the HILE to set up the endianess of
>>> memory-dump elf and since its not setup correctly the memory dumps are
>>> in wrong endianess.
>>>
>>>> I think the actual issue might be that we're calling
>>>> ppc_interrupts_little_endian with hv=true for the dump.
>>>>
>>> Yes, that is currently the case with cpu_get_dump_info(). Excerpt from
>>> that function below that sets the endianess of the dump:
>>>
>>>      if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
>> This should probably be looking at cpu->vhyp or MSR_HVB since
>> has_hv_mode will not change after we init the cpu.
>>
>>>          info->d_endian = ELFDATA2LSB;
>>>      } else {
>>>          info->d_endian = ELFDATA2MSB;
>>>      }
>>>
>>> for pseries kvm guest cpu->env.has_hv_mode is already set hence
>>> ppc_interrupts_little_endian() assumes its running in 'hv' mode. The new
>>> patch from Narayana will be addressing this.
>>>
>>>>> Currently the HILE bit is never set in the HID0 register even if the
>>>>> qemu is running in Little-Endian mode. This causes the guest dumps to be
>>>>> always taken in Big-Endian byte ordering. A guest memory dump of a
>>>>> Little-Endian guest running on Little-Endian qemu guest fails with the
>>>>> crash tool as illustrated below:
>>>>>
>>>> Could you describe in more detail what is your setup? Specifically
>>>> whether both guests are running TCG or KVM (info kvm) and the state of
>>>> the nested-hv capability in QEMU command line.
>>> Currently the issue is seen with any pseries KVM guest running on a PowerNV host.
> Okay originally I thought you were talking about a powernv target
> that is running a pseries guest and dumping that. But after re-reading, I
> think you're talking about dumping a pseries target?

yes, The qemu-memory-dump tested on different combinations like pseries
as well as powernv guests with and without -enable-kvm.

> Questions still remain about why that's the best way to go. If the
> target was running a nested-HV guest, is it reasonable that the guest
> can change the endinaness of the target dump on a whim by changing its
> ILE?
>
> Thanks,
> Nick

But the crash tool expects the endianness of the dump loaded should be same as
supplied debug kernel image endianness.
Detailed test cases we can find at V2 of this patch.
https://lore.kernel.org/all/20230509104701.12473-1-nnmlinux@linux.ibm.com/

Regards,
Narayana.

--------------ym03TX8EcgOZLs6w2sdva7in
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/15/23 12:02, Nicholas Piggin
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CSMN30SCVNA1.DOF9IMJOJRM5@wheely">
      <pre class="moz-quote-pre" wrap="">On Sat Apr 29, 2023 at 12:30 AM AEST, Fabiano Rosas wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Vaibhav Jain <a class="moz-txt-link-rfc2396E" href="mailto:vaibhav@linux.ibm.com">&lt;vaibhav@linux.ibm.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Hi Fabiano,

Thanks for looking into this patch and apologies for the delayed reponse.
Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a> writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Narayana Murty N <a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.ibm.com">&lt;nnmlinux@linux.ibm.com&gt;</a> writes:

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On PPC64 the HILE(Hypervisor Interrupt Little Endian) bit in HID-0
register needs to be initialized as per isa 3.0b[1] section
2.10. This bit gets copied to the MSR_LE when handling interrupts that
are handled in HV mode to establish the Endianess mode of the interrupt
handler.

Qemu's ppc_interrupts_little_endian() depends on HILE to determine Host
endianness which is then used to determine the endianess of the guest dump.

</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">
Not quite. We use the interrupt endianness as a proxy to guest
endianness to avoid reading MSR_LE at an inopportune moment when the
guest is switching endianness.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Agreed

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">This is not dependent on host
endianness. The HILE check is used when taking a memory dump of a
HV-capable machine such as the emulated powernv.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
I think one concern which the patch tries to address is the guest memorydump file
generated of a BigEndian(BE) guest on a LittleEndian(LE) host is not readable on
the same LE host since 'crash' doesnt support cross endianess
dumps. Also even for a LE guest on LE host the memory dumps are marked as BE
making it not possible to analyze any guest memory dumps on the host.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
From QEMU's perspective there's no "host" in this equation. We'll
generate a BE dump for a BE guest and a LE dump for a LE guest. Anything
different is a bug in QEMU (as the one this patch addresses).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm trying to figure out what's going on here. On one hand we are
creating a dump for/in the host. The dump is just a format that
describes register metadata, the same values can be represented just
fine with either endian. Memory has no endianness (without data
structures). So from that perspective, we do want to dump host endian
format.

OTOH crash could be taught foreign-endianness in which case the
endianness of the ELF file could be useful metadata about the
target I suppose. But ILE != MSR[LE] at any given time.

ILE seems like a half way house. It doesn't always give host endian
dumps so crash won't always work. It doesn't always give the machine
operating mode either. So why is it better to take guest ILE mode than
HV ILE mode?

I guess the first thing we need is a better and precise description of
the problem and the desired resolution. PPC64 has powernv and pseries,
both of which can support guests in various ways (PR, HV, nested HV),
and then when running guests the target itself also functions as a host,
so need to make all that unambiguous and use correct terminoogy in
the changelog.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">However setting the HILE based on host endianess of qemu might not be
the right way to fix this problem. Based on an off mailing list discussion
with Narayana, he is working on another patch which doesnt set HILE
based on host endianess. However the problem seems to be stemming from
fact that qemu on KVM is using the HILE to set up the endianess of
memory-dump elf and since its not setup correctly the memory dumps are
in wrong endianess.

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">I think the actual issue might be that we're calling
ppc_interrupts_little_endian with hv=true for the dump.

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Yes, that is currently the case with cpu_get_dump_info(). Excerpt from
that function below that sets the endianess of the dump:

    if (ppc_interrupts_little_endian(cpu, cpu-&gt;env.has_hv_mode)) {
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
This should probably be looking at cpu-&gt;vhyp or MSR_HVB since
has_hv_mode will not change after we init the cpu.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">        info-&gt;d_endian = ELFDATA2LSB;
    } else {
        info-&gt;d_endian = ELFDATA2MSB;
    }

for pseries kvm guest cpu-&gt;env.has_hv_mode is already set hence
ppc_interrupts_little_endian() assumes its running in 'hv' mode. The new
patch from Narayana will be addressing this.

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Currently the HILE bit is never set in the HID0 register even if the
qemu is running in Little-Endian mode. This causes the guest dumps to be
always taken in Big-Endian byte ordering. A guest memory dump of a
Little-Endian guest running on Little-Endian qemu guest fails with the
crash tool as illustrated below:

</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">
Could you describe in more detail what is your setup? Specifically
whether both guests are running TCG or KVM (info kvm) and the state of
the nested-hv capability in QEMU command line.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Currently the issue is seen with any pseries KVM guest running on a PowerNV host.
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Okay originally I thought you were talking about a powernv target
<pre>that is running a pseries guest and dumping that. But after re-reading, I
think you're talking about dumping a pseries target?</pre></pre>
    </blockquote>
    <pre>yes, The qemu-memory-dump tested on different combinations like pseries
as well as powernv guests with and without -enable-kvm.
</pre>
    <blockquote type="cite" cite="mid:CSMN30SCVNA1.DOF9IMJOJRM5@wheely">
      <pre class="moz-quote-pre" wrap="">
Questions still remain about why that's the best way to go. If the
target was running a nested-HV guest, is it reasonable that the guest
can change the endinaness of the target dump on a whim by changing its
ILE?

Thanks,
Nick
</pre>
    </blockquote>
    <pre>But the crash tool expects the endianness of the dump loaded should be same as 
supplied debug kernel image endianness. 
Detailed test cases we can find at V2 of this patch.
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230509104701.12473-1-nnmlinux@linux.ibm.com/">https://lore.kernel.org/all/20230509104701.12473-1-nnmlinux@linux.ibm.com/</a>

Regards,
Narayana.
</pre>
  </body>
</html>

--------------ym03TX8EcgOZLs6w2sdva7in--


