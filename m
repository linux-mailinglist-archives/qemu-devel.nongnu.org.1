Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F37F7AE178
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 00:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qktdO-0007NB-Cz; Mon, 25 Sep 2023 18:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qktd4-0007HC-V2
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 18:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qktd2-0003eO-HO
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 18:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695679230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ThlyCO4gVzuW2Y3UB0uv+FoM5vC0QsMhuX1bqv/xnk0=;
 b=DAICSoeWB600WE5dCkdwvKW5/qXFLbyrtBkZP+pEatMhcwVM+YudKQJEZyK77Vey9zq/rs
 +uIepDsYfbkjjd/6xmWdIroa7SsC2TcrHOmAZ3dr2cBp1pUjh8M0o//Kz14dfJG7t5t3iY
 EYY6RP0UmOxY3oHnISdAx5fr5LqH+6o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435--Msd3CgZP5GC_O0SWX8Nhw-1; Mon, 25 Sep 2023 18:00:28 -0400
X-MC-Unique: -Msd3CgZP5GC_O0SWX8Nhw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65b107812f0so42706126d6.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 15:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695679228; x=1696284028;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ThlyCO4gVzuW2Y3UB0uv+FoM5vC0QsMhuX1bqv/xnk0=;
 b=rrXFwau1OfabWFwmE4UD3/5qb/581f9riHR/nL0I01NY/LulxX0vUfhZMf0EehUBhN
 Pndo+W/SmmSUfcGdKSb0jZnf+9Vc3q+89gaUO3I6ZKH4ExAZQe09lz6zGGnM8T2bgZ87
 10BBAMx0uULbAZ5qDJ+lWvM+8mtawKsIJsyfShmNzHA2QBtkDF8XjSBnrXwmwuKPJEXf
 OjpC+FdPBgHnAp52dLDPuVuW0JiYC7dkgoE5UXc9vgtc5k9rcoR5Luf/INxzJWO6QTk5
 B7Moh7rMuNgZIMSj1RLiulatHW9v8JAm3lcHmihFPEQ0DpFbnP/2hZrnaNjXcq+GnUk2
 a/Fg==
X-Gm-Message-State: AOJu0YzyNUk5zFt06Pfl/hONorY1uaP+oBRMIf33lrktzQxA3NbCsXwh
 1C7kdW2y6sG5ezkKJpiR4RUjayBx0Ue7aGft5n0u4hkV8zRCteGP+i03vgJ/BsZpZNFMB93Kx8b
 yJc2YlyxoC3u+PXI=
X-Received: by 2002:a0c:c992:0:b0:65b:540:ed77 with SMTP id
 b18-20020a0cc992000000b0065b0540ed77mr5444247qvk.26.1695679227955; 
 Mon, 25 Sep 2023 15:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm04NN4MDG4UgUlx8ysyY9yyme4wI/bXqYq7JtUiDOTpPPn7trEhvM/r/zrwvM0qhjj3BpeQ==
X-Received: by 2002:a0c:c992:0:b0:65b:540:ed77 with SMTP id
 b18-20020a0cc992000000b0065b0540ed77mr5444230qvk.26.1695679227692; 
 Mon, 25 Sep 2023 15:00:27 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 i10-20020a05620a0a0a00b00774133fb9a3sm3640101qka.114.2023.09.25.15.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 15:00:26 -0700 (PDT)
Date: Mon, 25 Sep 2023 18:00:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v3 0/6] hw/virtio: Build vhost-vdpa.o once for all targets
Message-ID: <20230925175915-mutt-send-email-mst@kernel.org>
References: <20230710094931.84402-1-philmd@linaro.org>
 <ad508b5a-6cff-7138-1350-62a5bc513299@linaro.org>
 <1d971e7a-f6b6-3647-7cb7-5620d4f1532a@linaro.org>
 <c55cf435-c8ce-c1ff-d639-905ecf721ba3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c55cf435-c8ce-c1ff-d639-905ecf721ba3@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 18, 2023 at 12:42:02PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> On 6/9/23 08:31, Philippe Mathieu-Daudé wrote:
> > On 30/8/23 15:35, Philippe Mathieu-Daudé wrote:
> > > 
> > > This series is now fully reviewed.
> > > 
> > > On 10/7/23 11:49, Philippe Mathieu-Daudé wrote:
> > > > Missing review: patch #4
> > > > 
> > > > Since v2:
> > > > - Added R-b tags
> > > > - Addressed Richard's review comment: page_mask = -page_size
> > > > 
> > > > Philippe Mathieu-Daudé (6):
> > > >    hw/virtio: Propagate page_mask to
> > > >      vhost_vdpa_listener_skipped_section()
> > > >    hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
> > > >    hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
> > > >    hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
> > > >    hw/virtio: Build vhost-vdpa.o once
> > > >    hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]
> > 
> > Michael, I have another series unifying virtio endianness blocked
> > by this one. I can merge it if you provide your Ack-by.
> 
> Unless you object, I'll merge this series. Since we are early enough
> in the development window, if something breaks, we'll catch it in
> time and fix or revert.
> 
> Regards,
> 
> Phil.

It's actually in my tree, and should go out in a couple of days finally.

-- 
MST


