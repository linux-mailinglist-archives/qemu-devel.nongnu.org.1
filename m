Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 808227DD267
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:43:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrou-0000KU-Ia; Tue, 31 Oct 2023 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qxror-0000KJ-V7
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qxroq-0006Z3-Ev
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698770539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nknSEDENuPHevg1fGYEQw+Ixa7j6LlnpLc5nWQQetIM=;
 b=ZCDeC/EPTBdNoabFFU25IGyeYVMspJq6DPYGzi0CMBuhW0XopANTsfchi8qFJlWsOkkEqU
 /SmeVTRodOQ6fjflwMECZpDzOmfqczkX3/a8BCGTClrioerkTH1eCH+egc08kjZ1qV69sx
 IZTY7SDq023acHdBzLaKV8aLY/VEaR0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-r9qWSEt4MU6dQ2RCXYrrqA-1; Tue, 31 Oct 2023 12:42:12 -0400
X-MC-Unique: r9qWSEt4MU6dQ2RCXYrrqA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7ba7fb74544so190670241.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698770532; x=1699375332;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nknSEDENuPHevg1fGYEQw+Ixa7j6LlnpLc5nWQQetIM=;
 b=wn8jfmD/it09UI8Cfi5dss5jOI2lllmiuxJ/2d3j3ElF7JhuYG7ZZkqxvZD58/0aoc
 OVoO5N38T1NeKRBSPh6UGETxjCAlUfU2mYW12OWVPtGPGNRLdQe2OmDaTXOAh6xyeByP
 h9shnezm0yLmdZd5JYgDHECbKVV0F4lKeqV3ldMifCgHpPM6gQjtvibOZFdxiutynF1g
 JuFsSrSrhGOv5vYYvb5000mzq4iRnKeEG4K0CRn2KhjdbK/tkIc65cBhkMGancdz8yua
 Gekv2PzTeAxzM//BcjRhhqe6qFadKVTEW4lHzescb0dbOQHuOZ9kYDvD7V6iY+L3cIzo
 qGzg==
X-Gm-Message-State: AOJu0YwMkI40ZMqX99cG+eoW/1EglZFoIEjhE/U68Us4CZcV4gqKWLz9
 8OB7p4Y+MtfzyKogw3C3uaPQ5Pdwe3JrOMU5OW2WL6kV/PNf08Yqo2FmB0j4OPW5Opv4PZy5vgT
 cwyRPB9We3xFpw4DYNSj6dZLAQeGyieM=
X-Received: by 2002:a67:f254:0:b0:457:7138:fa74 with SMTP id
 y20-20020a67f254000000b004577138fa74mr9865381vsm.35.1698770531955; 
 Tue, 31 Oct 2023 09:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeh0X7+zNoIPZUxwmsP+2IRj65iyqYll3cF2NDEdU9fkrA0v33nQxfwk2lOfEuOt2GlxkTE2vACEYTBESLm4w=
X-Received: by 2002:a67:f254:0:b0:457:7138:fa74 with SMTP id
 y20-20020a67f254000000b004577138fa74mr9865372vsm.35.1698770531665; Tue, 31
 Oct 2023 09:42:11 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Oct 2023 09:42:10 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <5drfnt5rr5jmjl7xv65355squ2zzjra23mdrk5q3avnbue4kqx@7pmoj2zwfggx>
MIME-Version: 1.0
In-Reply-To: <5drfnt5rr5jmjl7xv65355squ2zzjra23mdrk5q3avnbue4kqx@7pmoj2zwfggx>
Date: Tue, 31 Oct 2023 09:42:10 -0700
Message-ID: <CABJz62PV8s=Dmh9cpa-3cRaLdNmUnW5zo4MYUA3=6kDdW8QbcA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] qapi-go: add generator for Golang interface
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 27, 2023 at 07:33:30PM +0200, Victor Toso wrote:
> Hi,
>
> Daniel & Andrea, it would be great to have your take on the Go
> side of this series. If we can agree with an acceptable
> 'unstable' version of Go modules, we can start building on top of
> this:
>  - libraries/tools in Go to interact with QEMU
>  - qapi specs to fix limitations (e.g: Data type names)
>  - scripts/qapi library wrt to generating interfaces in other
>    languages other than C
>
> I would love to have this prior to 8.2 feature freeze if the
> idea and current code meet your expectations.

Apologies for not providing any feedback so far. I'll do my best to
get around to it by the end of the week.

-- 
Andrea Bolognani / Red Hat / Virtualization


