Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780E7B50A6
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:50:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGUc-0008CW-Be; Mon, 02 Oct 2023 06:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnGUV-0008C2-Cj
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnGUT-0005uL-61
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696243768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmyLDNabvNIRwQMS9rXszLocUHJ+tc7LsHSRVrruEl0=;
 b=ZZg7x7YA5kVGqA4hyCqJ1egUkPTjlw/nbnqL7J03UAf2kQDQ9iinzsLcfYtaxfCR5lLk4Q
 puPm59cAi+/Prfqxjv0eJo7d3fYqvdEUTQBKZy5sJcsDUicmq6lfxSvRSA5r8WsG1Z2M4L
 30QzdMzRYFne72PjAO1snSQJtreEN9M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-gqnGaod7ObOMXiYpgviXgA-1; Mon, 02 Oct 2023 06:49:27 -0400
X-MC-Unique: gqnGaod7ObOMXiYpgviXgA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso12544213f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 03:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696243766; x=1696848566;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmyLDNabvNIRwQMS9rXszLocUHJ+tc7LsHSRVrruEl0=;
 b=IKk36SAb6RBNzcbYHnhN4wVqyKIbWUceV8I1dzm/6iLvefdIGorilhff2gPAZpVei+
 OZ0wa7xIIsYWGBXWFWXCf1eZGC+JraumXuKbghIPnRf+oCxSHboonmmQ5Z16A8gMgJvz
 ObSCmCK8RpjPBRTt2Gu/WHst1OT3IQODAvIEkhxl1VaPoc2BihPHIeGQRC/VWxZOfZWL
 AdX2bQ5FWeu4L9Hf+SOtC54Ba6ap9+Mbkibj/S5TnhGuDhR7Av1fowLqsZgLk2Bbjcde
 2dFhjehnkHPRzrPVDA1+jllenFM8d/KAkDEi/wrddR/jb4/SNHyT2A3L7gQOYB15Nk/3
 Km2w==
X-Gm-Message-State: AOJu0YxZ2CNNkh+zLYOGNRvJLDgd5sPdZEzxAZZl3LVvwI2m3AROW9hd
 rEs9y3lxY5gy698QNrWlxAfkKXqn9zzWKe1o8WwbkZswX67jImb83L/7S2Dr6aWGJ+CEJ3s7xt7
 XYClv6XWoOO6v1/E=
X-Received: by 2002:a5d:568e:0:b0:31f:e5cf:6724 with SMTP id
 f14-20020a5d568e000000b0031fe5cf6724mr9336923wrv.46.1696243765982; 
 Mon, 02 Oct 2023 03:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWo/NkKH6d5aGlnCzIwcJFWs6qup6mxJp7xNxmKCCQh+93EizuSANo95mvPfnns1YR/J4cMg==
X-Received: by 2002:a5d:568e:0:b0:31f:e5cf:6724 with SMTP id
 f14-20020a5d568e000000b0031fe5cf6724mr9336910wrv.46.1696243765653; 
 Mon, 02 Oct 2023 03:49:25 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 t6-20020a5d6906000000b00321773bb933sm9198936wru.77.2023.10.02.03.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 03:49:24 -0700 (PDT)
Date: Mon, 2 Oct 2023 06:49:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, imammedo@redhat.com
Subject: Re: [PULL 38/56] hw/acpi: changes towards enabling -Wshadow=local
Message-ID: <20231002064738-mutt-send-email-mst@kernel.org>
References: <20230929085053.2789105-1-armbru@redhat.com>
 <20230929085053.2789105-39-armbru@redhat.com>
 <8DAED4FD-46E5-461B-90C0-E14A3F83B137@redhat.com>
 <87zg142guv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg142guv.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 30, 2023 at 10:41:12AM +0200, Markus Armbruster wrote:
> Ani Sinha <anisinha@redhat.com> writes:
> 
> >> On 29-Sep-2023, at 2:20 PM, Markus Armbruster <armbru@redhat.com> wrote:
> >> 
> >> From: Ani Sinha <anisinha@redhat.com>
> >> 
> >> Code changes in acpi that addresses all compiler complaints coming from enabling
> >> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> >> other local variables or parameters. These makes the code confusing and/or adds
> >> bugs that are difficult to catch.  See also
> >> 
> >>    Subject: Help wanted for enabling -Wshadow=local
> >>    Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> >>    https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
> >> 
> >> The code is tested to build with and without the flag turned on.
> >> 
> >> CC: Markus Armbruster <armbru@redhat.com>
> >> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> >> CC: mst@redhat.com
> >> CC: imammedo@redhat.com
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >> [Commit message tweaked]
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > Thanks!
> > Are you not going to pick up "hw/i386: changes towards enabling -Wshadow=local” ?
> 
> Your conversation with Michael looked unfinished to me, so I didn't
> include your patch in my pull request.  I did add it to shadow-next.

Yes - I clarified what I meant. These patch just always
changed the name of the inner scope variable but that is not
always the best thing to do.

-- 
MST


