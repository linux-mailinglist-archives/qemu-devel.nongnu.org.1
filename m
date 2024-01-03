Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB78226B3
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 02:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKqRa-0005vt-1W; Tue, 02 Jan 2024 20:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKqRY-0005vG-1P
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 20:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKqRR-0007oG-A4
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 20:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704246787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/uGqtWmvz4p1ugM0b7fivdfjXcNokBhF1qZ0Z4R4JE=;
 b=VeItLEN9SrfHcvEDTPBH2s8hrTUBBOa8nfqktlmVnJ5lkpjalkFt9FVMkLRd8OTxrHDFwf
 21I6SF7i8dTmtGT6DwwfgnOBOQcy7CAYjbmh8zuWMGuICBhaOXpcJnqFEQElTZcE0kT1LA
 nk6+pePV+F8Aa9AHcBz72tQBzfntmqs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-cN1yCDNWMV2nOSjDmjePQw-1; Tue, 02 Jan 2024 20:53:05 -0500
X-MC-Unique: cN1yCDNWMV2nOSjDmjePQw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28c0765415eso1941332a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 17:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704246784; x=1704851584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/uGqtWmvz4p1ugM0b7fivdfjXcNokBhF1qZ0Z4R4JE=;
 b=nhy3gnDxgjDkvPLkJVA07gfCp/2WM3ev9HXjQMK74fk73oBNLxv3SBM4ckzT9qGP4S
 ML68AzawP7FN65isvwN1G/xTl/Q2JAbJNeQ+JM2SXNzRYicyzEMBW55xW5TQbO5zqDNn
 YfQ4FiHhPegGqJlzcdodi9KilRvDfHh+M77QW0BNyhG27FZ7Q38uvoHFFhhuBMPsAc3m
 pR/V5CoMpp73unyUh4hEUxZEyuYl7dTV0AfCiBJrbabKR0JQ6JxvIJXsV+mqn5IocyHR
 E777gSM8kSGtcICnOUdz6UizH09psUb/z3/WenOEj69oQT32uZbdxw0IVyhNQdWhhDQa
 tDmA==
X-Gm-Message-State: AOJu0YxsB7MSDoi1nJgaKW/s8c9dXm2w7dUBphj6JRX9jtvm2y5UhKne
 am/6KjtgsFC/0DUu4JCut+YyBG/dt9geHSmUkg9ezaFbYvT2qqMLx/SZnjG79vw3QX2S8Ybh8om
 4woTakgDOWzY8sk+fPlaJPNA=
X-Received: by 2002:a05:6a20:a3a1:b0:196:4d6a:ce0b with SMTP id
 w33-20020a056a20a3a100b001964d6ace0bmr15885598pzk.5.1704246784784; 
 Tue, 02 Jan 2024 17:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcuuv9m8zBFzNgpSA59phyvfUnFqeZ5kNpiN+5aS4IR/uNW+g6KXysb4ZIVSOQ/6D/0xxeTg==
X-Received: by 2002:a05:6a20:a3a1:b0:196:4d6a:ce0b with SMTP id
 w33-20020a056a20a3a100b001964d6ace0bmr15885592pzk.5.1704246784556; 
 Tue, 02 Jan 2024 17:53:04 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r15-20020a17090ad40f00b0028c952fd855sm290013pju.52.2024.01.02.17.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 17:53:04 -0800 (PST)
Date: Wed, 3 Jan 2024 09:52:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: QEMU developers call
Message-ID: <ZZS9-H2g6qjlY-4_@x1n>
References: <87mstno2ob.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mstno2ob.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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

On Tue, Jan 02, 2024 at 10:17:40PM +0100, Juan Quintela wrote:
> 
> Uv
> 
> Nf V nz yrnivat DRZH qrirybczrag, V pna'g unaqyr guvf pnyy.  Fubhyq
> nalbar gnxr pner bs vg?
> 
> V unir gnyxrq nobhg guvf jvgu Crgre, naq V guvax gung vs abobql fgrcf
> hc, ur pna "ibyhagrre" gb unaqyr vg.
> 
> Yngre, Whna.

If I'd make a list of good candidates, I'll probably be the last one out of
tens, especially considering my current timezone. :-D

Take care, Juan.

-- 
Peter Xu
# tr 'U-ZA-Tu-za-t' 'H-ZA-Gh-za-g'


