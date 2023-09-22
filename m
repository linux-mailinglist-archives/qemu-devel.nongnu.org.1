Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F07AAF5C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdIF-0002Ql-18; Fri, 22 Sep 2023 06:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjdID-0002Ph-1L
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qjdIB-00067Z-Gd
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695378105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuSfO03bL729B1NoYjfCBKlx0a+Y9oZ3bIRSwCKqsxw=;
 b=AyePlNCmenh5rTlx+wmNbrEuV31AIrkFELH2qauvSgvWVthdyrhsmHkyvrC+dYAqSDj2RR
 Uc77S5AJfwx7bHnK3X6wHU6zEYfWy+UlULK1OfZ5EBCgj/9OUUF5Q+OZ1SMZNqljY2YUJr
 oh/3wcN7j+i0FIGxNBR5AlZzgPD+egc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-rfsmd6BRM_i1sglLsXIueA-1; Fri, 22 Sep 2023 06:21:43 -0400
X-MC-Unique: rfsmd6BRM_i1sglLsXIueA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40478e6abd0so14387025e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695378102; x=1695982902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HuSfO03bL729B1NoYjfCBKlx0a+Y9oZ3bIRSwCKqsxw=;
 b=AjEkkvBZ/RcPB8XzLkFLk5bGs80xACFeUjQ6f5DcfCQMg0A3GZklbGBAvifuHfKlA8
 Zk9qLlqCz6oGs2L+Raj/pvje9kCqlXXt+x4VH1lngwrNzB+nc6dl4GFY3UymPgvxPly4
 PVhdie/dSHcLAy7rHJ/LPOpqnfKXXYZXWbOqnu8aCdqcyhyUR5PwIB49JcYCsacK16Hi
 7yGdkglDaFn18W2gR75h+eLVm5LacZBlg7LeryXVGlUeV7eDfLmXi0RY+/QT5HZOLAzb
 6+2N89JDGDUWn2DS/iul/r92O9qFzLC/3uHhVeJHHyIOPDQvsNYDsjBRvD/x260rWuJf
 jrtQ==
X-Gm-Message-State: AOJu0YzmtpgBgfak6yaG03HRiANpKd0fAOnmlvLQ7Yy1ylVmYgUsnLJE
 LsPo4tdpksQ6AZsD/0Xmd0O+l/O8ITmRADdfagxH8osEOrsM/R0sqp7BZou0kHL7l16HkpgZGBN
 ae53U0eOLqgVsr4Y=
X-Received: by 2002:adf:f104:0:b0:320:77f:a97c with SMTP id
 r4-20020adff104000000b00320077fa97cmr6588603wro.63.1695378102029; 
 Fri, 22 Sep 2023 03:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5LOLDWapg8ZnLulxbdLgGvfdLHmK9pO13GHCkdyUogu1jJ2aFfMtfYhywj9RBXqNp2O723w==
X-Received: by 2002:adf:f104:0:b0:320:77f:a97c with SMTP id
 r4-20020adff104000000b00320077fa97cmr6588595wro.63.1695378101665; 
 Fri, 22 Sep 2023 03:21:41 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 j3-20020a5d5643000000b0032167e49619sm4089625wrw.5.2023.09.22.03.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 03:21:41 -0700 (PDT)
Message-ID: <d2af7bf6-3079-366b-1ee4-280e2ca38659@redhat.com>
Date: Fri, 22 Sep 2023 12:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] pc_piix: remove pc-i440fx-1.4 up to pc-i440fx-1.7
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Hoffmann, Gerd" <kraxel@redhat.com>
References: <20230921121051.192355-1-pbonzini@redhat.com>
 <20230921121051.192355-2-pbonzini@redhat.com>
 <052e2425-f2fa-76ee-dd40-639d88210b4c@redhat.com>
 <CABgObfYgc2iF-89rPGL1siqvwXCGWPgP9Zs-2uOjj0j6jXVEfA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CABgObfYgc2iF-89rPGL1siqvwXCGWPgP9Zs-2uOjj0j6jXVEfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 22/09/2023 11.19, Paolo Bonzini wrote:
> 
> 
> Il ven 22 set 2023, 08:43 Thomas Huth <thuth@redhat.com 
> <mailto:thuth@redhat.com>> ha scritto:
> 
> 
>     While you're at it ... do we maybe want to start deprecating the next batch
>     of machine types already? (Say pc-i440fx-2.0 up to pc-i440fx-2.2 maybe?)
> 
> 
> It depends on the benefit. We would have to check the compat options that 
> are not needed anymore, and whether they'd be something that is useful 
> anyway for debugging.
> 
> Also it would be useful to check if isapc can drop some of the compat code 
> and realign itself to the 2.0 i440fx machine in terms of QEMU-specific features.
> 
> Because of all this todo, I decided not to proceed further with 
> deprecations. The 128k ROM on the other hand does provide immediate benefit.

FWIW, when I was working on deprecating the old pc machine types, I 
originally wanted to stop with pc-1.3 (since I was most bugged by the 
different naming between "pc" and "pc-i44fx" in the help output). I then 
only put the 1.4 to 1.7 machine types on the deprecation list without 
anything in mind. Now this became useful for the 128k bios rework... so 
maybe we should continue deprecating older machine types for other future 
reworks that we don't envision yet.

  Thomas


