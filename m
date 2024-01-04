Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901E82414D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:10:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMY9-0000l7-1Y; Thu, 04 Jan 2024 07:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLMY4-0000kV-8A
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:10:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLMY2-0001Rh-Ej
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704370201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aMXbT+/Zy7uCmpw+1grc+ldPlnhhUIUuOkODtLcq3p8=;
 b=RbbZjxpxAeikxw8GUyhogd5Y1WpdJC+wyp+04g6JoZ/O+fRksrBxjTuOw/TVn8H+ctXHC2
 GRh3ZJ0N5xffBkr/jkxzTQNe1a7SX+I2ZBg1k7Gq+KKZgztSgBO1w926iFxkTGRgxSKbfR
 roK3b6bi6o9ARjcgG5uQJmIkUW5G3mo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-EAZ08qGlPqKyFLTN4BKDdA-1; Thu, 04 Jan 2024 07:10:00 -0500
X-MC-Unique: EAZ08qGlPqKyFLTN4BKDdA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so75606b3a.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704370199; x=1704974999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMXbT+/Zy7uCmpw+1grc+ldPlnhhUIUuOkODtLcq3p8=;
 b=qNAWzBczXJVu2JAyCB4z6Z/uepBIfYxZJM4rQTH1ibAqGVpMHLtfSPG5TS/+PeEhsO
 dfazC6LwGViGQ89DZHJ+zYzxnxTw+7aZK1Ft1O3zNoCr5szbFGGLrdOxciNjQEAwzdVI
 1QhO7YtHZF9BEHokAKBvi5uszS8nFVb1VGmyL/RPZDS/X9BbWlNGTZYUq/FWR/qbIwCa
 3jjj+/3d2Pu8vgFse6bpmAtSIJD+xKhHw5NXkDtdsVslsO+yyrpYeFezY16P0N1QVS2S
 1WSXKQ/S1ngHPlWpnhmuLJbyfOZW3TsslCfVloElGMoRAV9IkbqCSb8KHUmFwzJFJlFC
 70Yg==
X-Gm-Message-State: AOJu0YyN0hctsZR+CO6Nge7vQYq04AI9fWkGdBGmx75ADpwvN/L3j7Tu
 zykII5ICLlsALEnzxsVtBgzVcI1VXvP3YALJhRX1eorhe0BLjp//4xCfTfH2mnD4aaOEoETNb5X
 u2MPZcxPmqbjwKJ9P7IXD+fzQfodH2pGUKmV3
X-Received: by 2002:a05:6a00:3d42:b0:6da:736d:67c8 with SMTP id
 lp2-20020a056a003d4200b006da736d67c8mr902715pfb.3.1704370198917; 
 Thu, 04 Jan 2024 04:09:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBzcbtSYwTgtLA78qr8/e+MX5/r00CiYQ7qO6UnZrSO2mDt6Ax2mSdVKJa7Zgdiv7UNMwE2g==
X-Received: by 2002:a05:6a00:3d42:b0:6da:736d:67c8 with SMTP id
 lp2-20020a056a003d4200b006da736d67c8mr902698pfb.3.1704370198581; 
 Thu, 04 Jan 2024 04:09:58 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v124-20020a626182000000b006d96d753ca0sm25598497pfb.38.2024.01.04.04.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 04:09:58 -0800 (PST)
Date: Thu, 4 Jan 2024 20:09:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: QEMU developers call
Message-ID: <ZZagDGqtfIUHWplA@x1n>
References: <87mstno2ob.fsf@secure.mitica> <ZZS9-H2g6qjlY-4_@x1n>
 <CAJSP0QWLzSuEkgNKQ=Yvw1VbGhoy-SNG+jiGg90jW3Bvmh7EHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QWLzSuEkgNKQ=Yvw1VbGhoy-SNG+jiGg90jW3Bvmh7EHw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

On Thu, Jan 04, 2024 at 06:46:41AM -0500, Stefan Hajnoczi wrote:
> On Tue, 2 Jan 2024 at 20:54, Peter Xu <peterx@redhat.com> wrote:
> > If I'd make a list of good candidates, I'll probably be the last one out of
> > tens, especially considering my current timezone. :-D
> 
> Does this mean you will handle the community call?

Probably not..  it's 10PM for me here, and I hardly never join the call.

Alex, I think you joined the call mostly every time when I joined, would
you take the lead?   Or Phil?  Anyone you would suggest?

Thanks,

-- 
Peter Xu


