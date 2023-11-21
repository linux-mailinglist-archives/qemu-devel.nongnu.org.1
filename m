Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A69A7F31CC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:01:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SFQ-0007fR-G1; Tue, 21 Nov 2023 10:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SFF-0007dR-M2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SFE-0004hi-68
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700578855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSeozPdoLTlhquVSO1rNcnwjTlc2KNOryylP8dBf8jY=;
 b=K/fAX2UyMSSjvR2EFsdRkM7TVQQWrhi1HyoH6fuIGoCptibcPBR33TuLNVJPjYi2Bwj/V+
 bbGBeX6E9CHiXt50ztX4RqeyvhZb8CKr1bod8uXDqRTvIMkbHW5KcygXm0ppFlzSHprUFs
 LUipQuS+IV/E0jHf0kzaizHUxYuyhBQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Sc8AIZ9lPKmMLkXFTr9nlA-1; Tue, 21 Nov 2023 10:00:52 -0500
X-MC-Unique: Sc8AIZ9lPKmMLkXFTr9nlA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6d6400cc382so518057a34.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700578851; x=1701183651;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSeozPdoLTlhquVSO1rNcnwjTlc2KNOryylP8dBf8jY=;
 b=gF5J6AnMxObqTkez85KOObztnk9U+aQweeg/kat2h5+phuojrZYEupPSgV2eXSedFu
 FUFhZcgH1HGi2yhtS9J59hP4Sl/ZUxEqdXD4ZL9l2BAw4isO9vkKld3ZSg1ErB038OuK
 fexqRsmJ2jjbPskVKwozvaZszGPQVN8VxYk18fxxulPbvHhYSwJJAiT+E+QOI+tbvNm5
 t0TnhckOCaT14WtT+RmykOTLmfMSSTHKv5cb75m3SCQmjevMGGkb6DLcP0KQuCDF9qlz
 h/B+jVRityIAKVV16JZkxuDiXUnuGlpBsaigWPJKBAy6Xg/BLvrew+YXBGrw0UV2IyBM
 7M7A==
X-Gm-Message-State: AOJu0YzP/biiHyoX+ruY5BmdJMwu9CbSMQRec1DgklCByk00oVPXPQtm
 Y/n3PWBQwHQxXrJQ9piy+Y9F6JOl6OOQI1KcdPYTQIj/uUkdPX8Rp9X+lHrJbSH60jifs+R42GB
 NhnI2f/HjGRtXkbg=
X-Received: by 2002:a05:6358:e49a:b0:16b:9551:4e20 with SMTP id
 by26-20020a056358e49a00b0016b95514e20mr9421277rwb.0.1700578851640; 
 Tue, 21 Nov 2023 07:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvgfaB578TNetey8QeB1/MZiI+EPgQd0tv7TrnGMGIhtvBFSqIsfkKQsr4yfmrncTnDdqcDw==
X-Received: by 2002:a05:6358:e49a:b0:16b:9551:4e20 with SMTP id
 by26-20020a056358e49a00b0016b95514e20mr9421243rwb.0.1700578851308; 
 Tue, 21 Nov 2023 07:00:51 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 p1-20020ac84081000000b0041b83654af9sm3641956qtl.30.2023.11.21.07.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:00:50 -0800 (PST)
Date: Tue, 21 Nov 2023 10:00:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH-for-9.0 10/25] memory: Have
 memory_region_init_rom_device() handler return a boolean
Message-ID: <ZVzGIXiHOWf00PYz@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-11-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 20, 2023 at 10:32:44PM +0100, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()

same

> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


