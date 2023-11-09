Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453877E7066
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:36:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18vs-0007xr-10; Thu, 09 Nov 2023 12:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r18vl-0007vB-Gz
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:35:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1r18vj-0002gi-To
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmYBomGCdOjHt/58fYuHshjiqDxuv41a04vVYCbBXlI=;
 b=bcpB5wgMaxKe0l+TGyEuwrLRRttGCa/YXDMA06xOdozFrs3hB7xy1VIP+II8bwGc/78MyO
 JoicNH8JJsoVUUbI82PYThHg6VnTY6KyccGCTf/VderMfUl9/y1lGAafdjIKP/8wzRRVv2
 YVierJxRGJzxIA0cpRRiKwJw96jk+oA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-N35WH-W_OIOI6ksuDqUSdA-1; Thu, 09 Nov 2023 12:34:58 -0500
X-MC-Unique: N35WH-W_OIOI6ksuDqUSdA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cc5b9d26eso34398721cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699551297; x=1700156097;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmYBomGCdOjHt/58fYuHshjiqDxuv41a04vVYCbBXlI=;
 b=BkpE5gYNlYh2imcNIx5FKyCCj5L9R9npdWORlVQVVcD9IPcNco9IFPkIRwA3aGgPsz
 CNCHYGaOT7TyL6AmK9RIuTXgRp5SgoHII/iiahBagkbUhq38y1aqAaBt2jpkJkklxq9r
 37+e0Uoh0aKU1j7VLDMeQjbRefeept40FKTGO3TqlZAeIauyRIrEaBo2QRRhKxZ2PCwl
 OFbIWA3Alhw8m0g8ghB5VTd32AEvqE+IE0OisjARjjT127M+5Z/JWXjLwfdbe4cYotAa
 O6prqLwXOxWdJhLi5LxWf+2Y41e6awKwpXq83ePg/TRx52TnklfQ6zthAOSTrgob+5+6
 VIAQ==
X-Gm-Message-State: AOJu0Yw/WHJpTKKnB4dmmnn6mawhP4QaCGujG58Pf3OYJH2yDhSdwAdn
 uw4hB4P16HnMEkSUH9jf3Acktv0mSsKrjVOWkvAdMrbWzeNTbLpMEF+kKzt0RocqCU9twrxGX7l
 fH8dA3AU0pm/gDs+yBL9RKTymF36uHL8gvJbwPTw=
X-Received: by 2002:a05:622a:14c7:b0:40c:21b2:40ab with SMTP id
 u7-20020a05622a14c700b0040c21b240abmr6877955qtx.22.1699551297090; 
 Thu, 09 Nov 2023 09:34:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV192V3KlwUoCMleiNZHU2uw+e0pgy3r9j0ozN1mb6o4XHRTr/fB/5yQxVrczjvJRN9Ps3D1ynel7fuKwdzfc=
X-Received: by 2002:a05:622a:14c7:b0:40c:21b2:40ab with SMTP id
 u7-20020a05622a14c700b0040c21b240abmr6877937qtx.22.1699551296880; Thu, 09 Nov
 2023 09:34:56 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Nov 2023 09:34:56 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
 <20231016152704.221611-5-victortoso@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231016152704.221611-5-victortoso@redhat.com>
Date: Thu, 9 Nov 2023 09:34:56 -0800
Message-ID: <CABJz62NbJAkLRS7t3JN8T-=1mkZ9BX68Jgd+VPr0tYwQPZNKag@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types in
 Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Oct 16, 2023 at 05:26:57PM +0200, Victor Toso wrote:
> [*] The exception for optional fields as default is to Types that can
> accept JSON Null as a value. For this case, we translate NULL to a
> member type called IsNull, which is boolean in Go.  This will be
> explained better in the documentation patch of this series but the
> main rationale is around Marshaling to and from JSON and Go data
> structures.
>
> Example:
>
> qapi:
>  | { 'alternate': 'StrOrNull',
>  |   'data': { 's': 'str',
>  |             'n': 'null' } }
>
> go:
>  | type StrOrNull struct {
>  |     S      *string
>  |     IsNull bool
>  | }

We should call this Null instead of IsNull, and also make it a
pointer similarly to what I just suggested for union branches that
don't have additional data attached to them.

-- 
Andrea Bolognani / Red Hat / Virtualization


