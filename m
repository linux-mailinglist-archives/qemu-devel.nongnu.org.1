Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101B7F32F7
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:59:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T9f-0006SU-Al; Tue, 21 Nov 2023 10:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r5T9R-0006Qh-I3
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r5T9O-0002xd-98
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700582332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70uEnos1LtUHQycomLB7LmE7flP2sa30VGj6fzwRMr4=;
 b=VKo27bGdBgTw+Bi3T84PkjBTsJt/0Ztif3UIQSr50Wz3AXb0J1Wv//BSck1eRkmQtmTKKy
 pyKSkzN1Db7Vm7u0NpLntgvizPx98cYSEZKADIUXg+dOfShF+CK52Ntz7vyUroHlG2Prpy
 yH0B5C/CD07wxgn5gvLPCFWtk+IpkLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Jm74miNnO-OtgT52YHRjKQ-1; Tue, 21 Nov 2023 10:58:49 -0500
X-MC-Unique: Jm74miNnO-OtgT52YHRjKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F66E811E7B;
 Tue, 21 Nov 2023 15:58:48 +0000 (UTC)
Received: from [10.39.194.228] (unknown [10.39.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 059B5492BE0;
 Tue, 21 Nov 2023 15:58:45 +0000 (UTC)
Message-ID: <7bfb52e6-3698-7c44-5927-31d47d031d57@redhat.com>
Date: Tue, 21 Nov 2023 16:58:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 00/16] hw/uefi: add uefi variable service
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Blake
 <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 mimoja@mimoja.de
References: <20231115151242.184645-1-kraxel@redhat.com>
 <9db15906-9474-4a6e-82a9-5275c72cf2b4@amazon.com>
 <nxzed5dhgjpn3fafjttocvxe6ztxxf5xhghaqncpdxup6y7o7y@47i3eyoehio2>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <nxzed5dhgjpn3fafjttocvxe6ztxxf5xhghaqncpdxup6y7o7y@47i3eyoehio2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
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

On 11/20/23 17:50, Gerd Hoffmann wrote:
> On Mon, Nov 20, 2023 at 12:53:45PM +0100, Alexander Graf wrote:
>> Hey Gerd!
>>
>> On 15.11.23 16:12, Gerd Hoffmann wrote:
>>> This patch adds a virtual device to qemu which the uefi firmware can use
>>> to store variables.  This moves the UEFI variable management from
>>> privileged guest code (managing vars in pflash) to the host.  Main
>>> advantage is that the need to have privilege separation in the guest
>>> goes away.
>>>
>>> On x86 privileged guest code runs in SMM.  It's supported by kvm, but
>>> not liked much by various stakeholders in cloud space due to the
>>> complexity SMM emulation brings.
>>>
>>> On arm privileged guest code runs in el3 (aka secure world).  This is
>>> not supported by kvm, which is unlikely to change anytime soon given
>>> that even el2 support (nested virt) is being worked on for years and is
>>> not yet in mainline.
>>>
>>> The design idea is to reuse the request serialization protocol edk2 uses
>>> for communication between SMM and non-SMM code, so large chunks of the
>>> edk2 variable driver stack can be used unmodified.  Only the driver
>>> which traps into SMM mode must be replaced by a driver which talks to
>>> qemu instead.
>>
>>
>> I'm not sure I like the split :). If we cut things off at the SMM
>> communication layer, we still have a lot of code inside the Runtime Services
>> (RTS) code that is edk2 specific which means we're tying ourselves tightly
>> to the edk2 data format.
> 
> Which data format?
> 
> Request serialization format?  Yes.  I can't see what is wrong with
> that.

... I can't even see what's wrong with *that*. Realistically /
practically, I think only edk2 has been considered as guest UEFI
firmware for QEMU/KVM virtual machines, as far as upstream projects go.
It's certainly edk2 that's bundled with QEMU.

My understanding is that firmware is just considered a part of the
virtualization platform, so teaching edk2 specifics to QEMU doesn't seem
wrong. (As long as we have the personpower to maintain interoperability.)

> We need one anyway, and I don't see why inventing a new one is
> any better than the one we already have in edk2.
> 
> Variable storage format?  Nope, that is not the case.  The variable
> driver supports a cache, which I think is a read-only mapping of the
> variable store, so using that might imply we have to use edk2 storage
> format.  Didn't check in detail through.  The cache is optional, can be
> disabled at compile time using PcdEnableVariableRuntimeCache=FALSE, and
> I intentionally do not use the cache feature, exactly to avoid unwanted
> constrains to the host side implementation.
> 
>> It also means we can not easily expose UEFI
>> variables that QEMU owns,
> 
> Qemu owning variables should be no problem.  Adding monitor commands to
> read/write UEFI variables should be possible too.

This patch set is actually an improvement towards QEMU-owned variables.
Right now, all variables are internal to the guest; QEMU only has a
pflash-level view.

> 
>> which can come in very handy when implementing MOR
>> - another feature that depends on SMM today.
> 
> Have a pointer for me?  Google finds me
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-guard-requirements,
> which describes the variable behavior (which I think should be no
> problem to implement), but doesn't say a word about what exactly gets
> locked when enabled ...

See:

  TCG PC Client Platform
  Reset Attack Mitigation Specification

My copy is

  Family “2.0”
  Version 1.10 Revision 17
  January 21, 2019
  Published

You should find it somewhere in the download area of
<https://trustedcomputinggroup.org>.

E.g....
<https://www.trustedcomputinggroup.org/wp-content/uploads/Platform-Reset-Attack-Mitigation-Specification.pdf>


In the past we've had a bunch of discussions / patches around this. Some
examples:

- [edk2] multiple levels of support for MOR / MORLock

http://mid.mail-archive.com/039cf353-80fb-9f20-6ad2-f52517ab4de7@redhat.com

- https://bugzilla.tianocore.org/show_bug.cgi?id=727

(see edk2 commit range listed there, too)

- commit 704b71d7e11f115a3b5b03471d6420a7a70f1585

- commit d20ae95a13e851d56c6618108b18c93526505ca2

- https://bugzilla.redhat.com/show_bug.cgi?id=1854212

- https://bugzilla.redhat.com/show_bug.cgi?id=1498159


> 
>> In EC2, we are simply serializing all variable RTS calls to the hypervisor,
> 
> The edk2 code effectively does the same (with PcdEnableVariableRuntimeCache=FALSE).
> 
>> similar to the Xen implementation
>> (https://www.youtube.com/watch?v=jiR8khaECEk).
> 
> Is the Xen implementation upstream?  Can't see a xen variable driver in
> OvmfPkg.  The video is from 2019.  What is the state of this?

Not sure about the current state, but when that presentation came out,
we discussed it briefly internally. I don't have time to review that old
discussion now for the sake of potentially publishing it inside this
discussion, but for interested Red Hatters, I can provide a pointer:

  [virt-devel] Securing Secure Boot on Xen | FOSDEM'19
  Date: Fri, 8 Feb 2019 20:46:46 +0100
  msgid: <37382312-986c-4ce4-1ba3-942697738d65@redhat.com>

> 
>> The edk2 side code we have built is here:
>> https://github.com/aws/uefi/tree/main/edk2-stable202211 (see anything with
>> VarStore in the name).

Well... why was this never upstreamed to edk2? (Side question, of course.)

> 
> Ok, so it's just the variables.  The edk2 variant also sends variable
> policy requests (see Edk2VariablePolicyProtocol,
> https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/VariablePolicyLib/ReadMe.md).
> And it can easily be extended should the need arise in the future (all
> requests are tagged with a protocol/event guid).
> 
>> Given that we deal with untrusted input, I would strongly prefer if we could
>> move it to a Rust implementation instead though.
> 
> Valid point.

Agree that the point is valid.

(And this was one of my concerns, if not my main concern, in the above
internal discussion, about Xen varstored.)

Especially due to the heavy crypto that the final version is supposed to
have.

Even during the present patch review, while going through only the
headers thus far, I've already said at least twice that we're going to
have to be super careful about integer overflows and buffer overflows.
Any such problem is no longer a guest<->guest privilege boundary breach
but a guest<->host one.

Not sure if the suggested remedy ("write it in Rust") is practical.

> 
> I've started in C because I have next no to experience with rust (yet),
> so getting a test-able / demo-able implementation done was much easier
> for me.  Also I think we don't have any rust infrastructure in qemu
> (yet?).  Being able to use the qapi / qobject support to read/write the
> variable store in json format is nice too.
> 
> But I'm open to discuss other options.

A selfish aspect: given that I've been reviewing this set, should I
consider it a proof of concept / prototype, or something we might want
to build upon, i.e., should I assume we'd put these foundations into
production at some point? I've been reviewing the series with the latter
in mind, but if that's not correct, I should probably adjust my pedantry
knob.

> 
>> We started a Rust
>> reimplementation of it that interface that can build as a library with C
>> bindings which QEMU could then link against:
>>
>>   https://github.com/Mimoja/rs-uefi-varstore/tree/for_main
>>
>> The code never went beyond the initial stages,
> 
> Hmm.  Why not?

And I'm a bit annoyed that you had to write ~2500 lines of QEMU code
(not counting edk2) for qemu-devel to learn about these initiatives. :/

> 
>> but if we're pulling the variable store to QEMU, this would be the
>> best path forward IMHO.
> 
> Ok, so you are trying to sell me a prototype as solution?
> /me looks a bit skeptical ...

at least with virtiofsd, we had gone with a C impl first, and only then
with a Rust impl...

Laszlo


