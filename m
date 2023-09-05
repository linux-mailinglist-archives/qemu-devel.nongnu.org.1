Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC787923E7
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXsM-0000WI-CK; Tue, 05 Sep 2023 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qdXsK-0000Vx-Lk
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:21:56 -0400
Received: from mout-p-102.mailbox.org ([2001:67c:2050:0:465::102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qdXsI-0002b3-86
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:21:56 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Rg8P90qP0z9srq;
 Tue,  5 Sep 2023 17:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
 t=1693927309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+Vsyzfk4aANJgScXjguA5u+ZdRi88msY78wdWMxiYg=;
 b=p+j/Idm57XqNJsg1uKxxDDAYwZv6mYofLpFc8rxU44lRXrb8UU2yhEDJA42o68wh9L0xBm
 q/XJL6QXi0ZjWkmbmEnCaaMTIup9ts3L3kAeys6G9nCTy0wZoVEEgpp8fiUYw5KbdS2UQ4
 ky+4pD7V6tim4hrW3YAv7pAJG7igb1DS7WZP4MJFyjHM7rMU8jpOr6KFb1oDdFuxVquASV
 ziMbBh6lN8alZlhdtnXBHTveOAvMBVf0rNaLO+8OoU509yD2nVUjIjOjykJSE7w3Dd4YPG
 1Bg7LAHTiMKF4+3lufljwYYNDSYHByJiyEDNpvuJI+KmXlo45TE+d0N4bOzOtQ==
Message-ID: <c0b3fb75-3797-49dd-aa0c-6798b7f9206b@sylv.io>
Date: Tue, 5 Sep 2023 17:21:46 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
 <0d882c9c-a95c-3c0b-8e95-da729ad16b32@linaro.org>
From: Marcello Sylverster Bauer <sylv@sylv.io>
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
In-Reply-To: <0d882c9c-a95c-3c0b-8e95-da729ad16b32@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Rg8P90qP0z9srq
Received-SPF: pass client-ip=2001:67c:2050:0:465::102;
 envelope-from=sylv@sylv.io; helo=mout-p-102.mailbox.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Philippe,

On 9/5/23 17:09, Philippe Mathieu-Daudé wrote:
> Hi Marcello,
> 
> On 5/9/23 17:05, Marcello Sylverster Bauer wrote:
>> Greetings,
>>
>> I'm currently working on a project to support Intel IPU6 in QEMU via 
>> VFIO so that the guest system can access the camera. This requires 
>> extending the ACPI device definition so that the guest knows how to 
>> access the camera.
>>
>> However, I cannot extend the PCI devices because their names are not 4 
>> characters long and therefore do not follow the ACPI specification.
>>
>> When I use '-acpitable' to include my own SSDT for the IPU6 PCI 
>> device, it does not allow me to declare the device as an External 
>> Object because it automatically adds padding underscores.
>>
>> e.g.
>> Before:
>> ```
>> External(_SB.PCI0.S18.SA0, DeviceObj)
>> ```
>> After:
>> ```
>> External(_SB.PCI0.S18_.SA0_, DeviceObj)
>> ```
> 
> What do you mean by "before" / "after"?

Before is what is written in my SSDT ASL source file that is provided to 
QEMU via the "-acpitable" flag. After is what is actually written to the 
SSDT inside the VM.

If you compile and decompile the source file with iasl, you will get the 
same result.

> 
>> Adding the underscore padding is hard coded in iASL and also in QEMU 
>> when parsing an ASL file. (see: build_append_nameseg())
>>
>> So here are my questions:
>> 1. Is there a solution to extend the ACPI PCI device using 
>> '-acpitable' without having to patch iASL or QEMU?
>> 2. Are there any plans to change the names to comply with the ACPI 
>> spec? (e.g. use "S%.03X" format string instead)
>>
>> Thanks
>> Marcello
>>
> 

