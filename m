Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 054747478EB
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 22:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGmMn-0004j1-A9; Tue, 04 Jul 2023 16:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qGmMl-0004is-GS
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 16:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qGmMj-0007V4-P8
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 16:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688501471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TastBQafAvHliTR+H8WJWs0WdTZNRdzlcZ7GPC2yDOg=;
 b=C2ut3es9SU5GZjagZQMVz1NIRSMKDrQC2tSOzt6AZ4aa4WjTIRXcqUw1YqBUJ+yrF7Oxoq
 hKKDZK+r8C0VNDs6R64t93K2wAK7f5YkxK3JStCVq8dX1x5yXUz8NxRB+WirHg99pL2OMF
 gqwcCi0xJZsa7OPK7AXBqb91wcf4di4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-TdkNuwNRMWaMgVvOmgdkBQ-1; Tue, 04 Jul 2023 16:11:10 -0400
X-MC-Unique: TdkNuwNRMWaMgVvOmgdkBQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765ad67e690so109500085a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 13:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688501469; x=1691093469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TastBQafAvHliTR+H8WJWs0WdTZNRdzlcZ7GPC2yDOg=;
 b=b/DrkGC/PKQ7BXu7f2V+TFeA3UZdjgz3KjmLfSpqU/d1nayScL+51Pef9v2mkDe8Hn
 hv5iYT4FtYwxANfega2lrkr1xPTWkzbJo9n16twhqRMQoJqHy9XC6VsCdNcKx6J8IT2c
 0S11SmXAFO7gffJO+L+egDHV1JL8KfW9/FJv744G1PqdNzvByxTBkrq8C7/KxUfO7mZy
 y1Bue1REp2eXnsEDUEwkBYuPWc9tCXhcRqBxHHFtVMsNVsJtz9YIPPj2pTQdF9wnC4y0
 wbLulA01A1Ecu84qrduiEmarB6y1vkc1DtLPhxxBczpixCsL80k6NuR/Cf3QSwHsXKOs
 CcJA==
X-Gm-Message-State: AC+VfDzRinRCiV3N8ct50dkq1odmZwIhxYZXyBwa31/05VKOULhx/vr4
 hybQqXbUutWrsGYLya4cKswkPCY6Rak0iZuLkilJQTfqfdO8WsjKFRnqVCBIbs8lSD5/DargMc4
 nSPEzQXiioopeNVc=
X-Received: by 2002:a05:620a:370e:b0:767:ffb:58aa with SMTP id
 de14-20020a05620a370e00b007670ffb58aamr17007961qkb.3.1688501469620; 
 Tue, 04 Jul 2023 13:11:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yzh/zT5sFMlWUZvKVrCoyRtL/iCvVilXFsOkwM/Ce2LzjuNffoRWF1ihPQ+WbUq9fKdFjag==
X-Received: by 2002:a05:620a:370e:b0:767:ffb:58aa with SMTP id
 de14-20020a05620a370e00b007670ffb58aamr17007940qkb.3.1688501469291; 
 Tue, 04 Jul 2023 13:11:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c5-20020a05620a11a500b00765aa9e3499sm9868429qkk.135.2023.07.04.13.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 13:11:08 -0700 (PDT)
Date: Tue, 4 Jul 2023 16:11:07 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: Memory region endianness
Message-ID: <ZKR82+54jTZK9Gj4@x1n>
References: <873fa402-8e75-1ea1-6806-26b93d3ac714@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <873fa402-8e75-1ea1-6806-26b93d3ac714@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 30, 2023 at 01:37:49AM +0200, BALATON Zoltan wrote:
> Hello,
> 
> Some devices have bits that allow the guest to change endianness of memory
> mapped resources, e.g. ati-vga should allow switching the regs BAR into big
> endian on writing a bit. What's the best way to emulate this?
> 
> The naive way could be to just test for the bit in the memory ops call backs
> and do the swap there, but that would add overhead when it's not needed
> (most guests don't need it) and there are two BARs to access the same
> registers (one is in an IO BAR that aliases part of the MEM space BAR) and
> these may need to have different endianness so I'd rather have the memory
> layer handle it.
> 
> Now the question is how can the endianness be changed from the memory ops
> call back? Is it allowed to overwrite ops.endianness or replace ops with
> another one that has DEVICE_BIG_ENDIAN? In MemoryRegion the ops field is
> declared const and nothing seems to try to change it so I guess it might not
> be changed.
> 
> Then do I need to define two memory regions one with little and another with
> big endian and unmap/map those when the bit is written? Can this be done
> when a write to the bit happens with LE ops then is it possible from the
> callback ro unmap the memory region being written and replace it with
> another? Is there any other easy simple way that I'm missing?

I hope it'll just work as you said.  It seems the same case to me comparing
to other memory region updates within an MMIO callback, no matter whether
the new MR only switched the endianness, or something else has changed.

Thanks,

-- 
Peter Xu


