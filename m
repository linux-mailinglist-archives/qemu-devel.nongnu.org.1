Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A180E2D1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 04:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCtWu-0001TY-Us; Mon, 11 Dec 2023 22:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCtWr-0001TD-Bv
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 22:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCtWp-0006xV-SI
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 22:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702352030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHjTL0avq5qwPAJbCm9Z3Oyfq0BIj8XfjlRdmzJakFg=;
 b=JoSV48YPeystneejsUuTfatlag4rWtHd7xMZm7abjaqPlRGhSJyWjezmpFHOfWCdeJSuwz
 aKrtF9EecGW2vmsRcs0IhYHFjsfEy8Ijl6YbvQnhDk5X7ZVFtGkWpMQi6/Z10xQNI6n2lL
 umDlH74cysS5g/zKMLVJyeXzoRwKYuE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-munF1sAOOJysJhUWzmRU7w-1; Mon, 11 Dec 2023 22:33:48 -0500
X-MC-Unique: munF1sAOOJysJhUWzmRU7w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77f360c8a64so644700885a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 19:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702352027; x=1702956827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHjTL0avq5qwPAJbCm9Z3Oyfq0BIj8XfjlRdmzJakFg=;
 b=UDgwuVCw0BJNrFCI+jBoAQUomgbxgIIRvox88C9WYox7ea6l/XgOtOiZKJxhYPgNfx
 LVRfZppuQJ/V+zWG0rG/OW09/HBGO/PiQZPnWTgWsoMo2lCiiI+QZpsstPed0PHi3Bxj
 nUVe3g80gH2dGo6uv95Trk/kGQzH2MLEGUPW4LqddXApeWbvOxNVwxaoRbZhIJMuGlWy
 ZCh3lDIXz/UiJcIW5yzbY3IYEre7/h+1eatdGDcG3SJrB3hGpmvcbpiTWVXmP5rmu9Ar
 oLFOWx3qOWQvCMDONaYi73qXmx3pO0Z4JbnE/dfk/iD+s/WaNToa6CcRPyA6KCtedG8R
 290Q==
X-Gm-Message-State: AOJu0YySxiIQaqAdTJiamGKY2ZDBbJnl+vCYAaczsCPieUugBpBGtVYZ
 OX/KNY+5eJxkUo1eQdBLq13Bmms5MK7XyzthSqkX8MilrBiGSSIDWgEAdzyAdh6bOJPmQxKf5J1
 b5DKfzfN5cJnpSZXPMInzRA19RB6RJso=
X-Received: by 2002:a05:620a:c85:b0:77f:3301:535c with SMTP id
 q5-20020a05620a0c8500b0077f3301535cmr5827753qki.54.1702352027696; 
 Mon, 11 Dec 2023 19:33:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCAlEvSoJI9gtt0UBLQ7O2L7qGgRlrcnAE/HbvtvIfMlpiUqJyILD1bbfc0H+oeyaSEPoB+n//5SgYfVVpHBY=
X-Received: by 2002:a05:620a:c85:b0:77f:3301:535c with SMTP id
 q5-20020a05620a0c8500b0077f3301535cmr5827741qki.54.1702352027437; Mon, 11 Dec
 2023 19:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-6-andrew@daynix.com>
 <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
 <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
 <CAOEp5OcMo+eZ=k4m7ZKvSLWfngzzaZ6eHMLaiTmZ3CQ_yE2aKw@mail.gmail.com>
In-Reply-To: <CAOEp5OcMo+eZ=k4m7ZKvSLWfngzzaZ6eHMLaiTmZ3CQ_yE2aKw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 11:33:36 +0800
Message-ID: <CACGkMEtFKJovdfi6690uoqH_qJ3mP6K8KDFcOamvC1yOow-Drg@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ebpf: Updated eBPF program and skeleton.
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Andrew Melnichenko <andrew@daynix.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Dec 11, 2023 at 7:51=E2=80=AFPM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> Hello Jason,
> Can you please let us know what happens with this series?

It should be my bad, it is in V1 of the pull request but missed
accidentally in V2 of the pull.

I've merged it here,

https://gitlab.com/jasowang/qemu.git

Please check if it's correct.

Thanks

>
> Thanks
> Yuri
>
> On Fri, Sep 8, 2023 at 9:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>>
>> On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko <andrew@daynix=
.com> wrote:
>> >
>> > Hi Jason,
>> > According to our previous conversation, I've added checks to the meson=
 script.
>> > Please confirm that everything is correct
>>
>> I've queued this series.
>>
>> Thanks
>>


