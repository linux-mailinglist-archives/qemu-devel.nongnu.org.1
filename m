Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD88B761E3C
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 18:16:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOKh7-0007HW-RV; Tue, 25 Jul 2023 12:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOKh2-0007GY-QK
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOKgx-00028v-PX
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690301719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qHODOC0JDFtiG3m+DhGEfhyrvhbEwygELu1oRSw3s7U=;
 b=g3NCKULFgCiFvOt8ghW9ek47BMiEqYYOopTDZw/GLuPh9InL56+F/lJeo39TR99dUoL2KP
 4tzZpDxd8akCY2UJl8qOAQu1ZsjDadB1iNqiJu9WjBAmftfecI4e2eqNYORWJ/qX5xI8It
 BQZXjamhTqrCakPItQl6A9U+ZoCA8ME=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-KrvYaCaQPQ2XWVdTz7g5nw-1; Tue, 25 Jul 2023 12:15:16 -0400
X-MC-Unique: KrvYaCaQPQ2XWVdTz7g5nw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-997d144f31dso334571466b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 09:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690301714; x=1690906514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qHODOC0JDFtiG3m+DhGEfhyrvhbEwygELu1oRSw3s7U=;
 b=QTAB1W099SXFG3TDOxJVpw2nOH2gnKMd3MrxfXBxb0ZsooWnCXagvTRE1Uv3QNR+UY
 DlOQ3SFVhdTgeGGYFPwAsLAeissb9MvOTHY76yGwvq+afthsg/wL+db9dRpAYNwF2t42
 0K/Du2e0dayt5mRjZOWzbq9UvCJmV4x80pVCyFvOLhBT0Vut+Kt7XLbYwLcFRGgqB8TF
 kkofa12ZSbDLtdMEMUIEvA5SnEeciCOnroWEFUxIuEO6s81bqPpfPuhlKEq7NX88myft
 jolgBN5S7IRWynYpXc7CWqHVyE8HbYF01V23W8OfpT/6Rq6wXMdg5yved2NcaKygBbEg
 9SNA==
X-Gm-Message-State: ABy/qLbskvuHE5lr6O3gX8scNrQAvFZPOydBh1Tle2QcXMdj9g2gqTqi
 siOvQUQdzg2dH2ETqBuUCfuswYA1mVxuyoVp59V6df8xdj4/6BKs/cyp9W/kmJZSy0/MWyZ9E72
 axsT1i1UaQ0++teM=
X-Received: by 2002:a17:906:1059:b0:993:d6e8:2389 with SMTP id
 j25-20020a170906105900b00993d6e82389mr15126595ejj.26.1690301714756; 
 Tue, 25 Jul 2023 09:15:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE60wa0qeKngqVizUskMYfrqBTLlmFffPlgSgX5gzzYzBGjsT+E8D9yA0DiggXeyEawGaXo6g==
X-Received: by 2002:a17:906:1059:b0:993:d6e8:2389 with SMTP id
 j25-20020a170906105900b00993d6e82389mr15126578ejj.26.1690301714488; 
 Tue, 25 Jul 2023 09:15:14 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 la6-20020a170906ad8600b00993c29eff7dsm8354623ejb.138.2023.07.25.09.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 09:15:14 -0700 (PDT)
Date: Tue, 25 Jul 2023 12:15:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 Alex Bennee <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
Message-ID: <20230725120945-mutt-send-email-mst@kernel.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <f267d41957025b3849324f459a8ed476aa89f828.1689857559.git.manos.pitsidianakis@linaro.org>
 <CAJ+F1C+H+82cA=mhpju-2nxRSA3BWnWJmp4-pi+G=Lsri0oGTw@mail.gmail.com>
 <20230725104417-mutt-send-email-mst@kernel.org>
 <CAJ+F1CLZ-p=L-7h6BdP_eCYGe9Cn+k+hUi=7aj-5LrNj_W1E0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLZ-p=L-7h6BdP_eCYGe9Cn+k+hUi=7aj-5LrNj_W1E0g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 25, 2023 at 06:54:56PM +0400, Marc-André Lureau wrote:
> 
>     Marc-André can you please stop with trying to use gmail web client?
> 
> 
> Trying? I think I have almost exclusively used it over the past 15y or so :)
>  

Then find a way make it not wrap lines.  The result of corrupted text is
people giving up in disgust and asking everyone to switch to gitlab
or slack or whatnot.

-- 
MST


