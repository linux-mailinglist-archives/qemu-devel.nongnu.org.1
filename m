Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9C75BF25
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 08:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMk23-0005AB-8S; Fri, 21 Jul 2023 02:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMk21-0005A2-An
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMk1z-0002g5-Ox
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689922467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLzCBMpUiHQ0KGS74hdXoJ+W3DCKIodv85ArHmbFIoE=;
 b=BN0sfq+TUcnIHSV2rrprYs9RYOI7e+HRdn4a26WpqgYXTL49wR+mdENcbqM2rY6ZNG9Bni
 JlE0+Cq411dprOWw22zgf+Nnyvzb5g/IhYic8XDVRPMm/Lo5AuTFCRdh+mR5XiSKb5oBvT
 qFpNv2nw97vIl1+9zsi7fupAOj0JB9U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-AO9FH6oOPh2bN4QML1rs9Q-1; Fri, 21 Jul 2023 02:54:25 -0400
X-MC-Unique: AO9FH6oOPh2bN4QML1rs9Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-316f24a72e9so979521f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 23:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689922464; x=1690527264;
 h=content-transfer-encoding:in-reply-to:subject:from:cc:references:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DLzCBMpUiHQ0KGS74hdXoJ+W3DCKIodv85ArHmbFIoE=;
 b=GuuJLtlzHylVjGADZ/N8HTXamh/nnVLsn79HJrVnuO4QlhggqQEdcYYWiX273W1Wmn
 s3A7R8izD6/+j6hzaEOHsiNCdZXKNzJ6FJhQiOEy23+U2W5V2ioXrsWvyqB6xw9q/yY8
 QfsOUA7JuGhUOnYF8RMEeREGy1uVh3tBjvSMlpdEe+0/VABnJhjz8nGHsS+kXoCxRr1Q
 tskfhGbozBmH1WfhkEZTesCJOActTlTMmH0K9ccU1/w/cx4s/iBRorN2L68eTB70ptay
 IorZgRu42W2tlpNfmXmjdXu2Kc/sVobeDfL7Zr5fBvptKoBnqbrlsKEKbdNSzKEoWARn
 iZ2w==
X-Gm-Message-State: ABy/qLaxJJoHTvM6pMcHcTXZCm+O3UKWVqqSbm5E2RAC6KmrnKW7Vg7j
 JXdYfyRiplmd1MANupP3J7O/qn27tjWI/WpvElIxwoCri3dalj0fL4Bhzgu+tA6tvp+YqVDju7u
 seBrCvVjVFIhj3D4=
X-Received: by 2002:a5d:6847:0:b0:314:46cd:66c5 with SMTP id
 o7-20020a5d6847000000b0031446cd66c5mr686407wrw.27.1689922464239; 
 Thu, 20 Jul 2023 23:54:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFk1M2cFGicEDpyM1L1rvQEdPU8kRNjAjm5sGTg5gjLE9CHrlW7D+wTcswpRvVi96OtYXtnBQ==
X-Received: by 2002:a5d:6847:0:b0:314:46cd:66c5 with SMTP id
 o7-20020a5d6847000000b0031446cd66c5mr686398wrw.27.1689922463917; 
 Thu, 20 Jul 2023 23:54:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 c16-20020adfe750000000b0030fb828511csm3316871wrn.100.2023.07.20.23.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 23:54:23 -0700 (PDT)
Message-ID: <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
Date: Fri, 21 Jul 2023 08:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: 8.1-rc0 testfloat fails to compile
In-Reply-To: <20230720224656.2841ff5f.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20/07/2023 22.47, Olaf Hering wrote:
> This is going on since a few weeks. I guess there is no check in CI to see if qemu.git#master compiles in Tumbleweed.

We only have a check for openSUSE leap ...
Which compiler version is causing trouble for you?

> Since the switch to meson submodules, berkeley-testfloat-3 became mandatory. I think in the past I was able to ignore this submodule and not export it, so the following error did not show up:
> 
> [  141s] ../subprojects/berkeley-testfloat-3/source/genCases_f64.c: In function 'f64Random':
> [  141s] ../subprojects/berkeley-testfloat-3/source/genCases_f64.c:559:1: error: control reaches end of non-void function [-Werror=return-type]
> [  141s]   559 | }
> [  141s]       | ^
> [  141s] cc1: some warnings being treated as errors
> 
> Apparently this is a known issue, 3ac1f81329f attempted to ignore such errors.

Seems like the flag got lost in commit d2dfe0b506e47e14 ... Paolo, any ideas?

> Do I need to tweak the global, system-provided CFLAGS myself, or can the source be fixed to address this? Disabling this error globally will hide errors elsewhere.

We are using a forked version of the berkeley-testfloat repository, and it's 
possible to add patches there:

  https://gitlab.com/qemu-project/berkeley-testfloat-3

The f64Random function that you mentioned above could easily be fixed by 
adding a "default:" case to the switch statement, I think. Are there any 
other additional warnings/errors after fixing this?

Feel free to send a patch and CC: the people from 
https://gitlab.com/qemu-project/berkeley-testfloat-3/-/project_members

  Thanks,
   Thomas


> Maybe there is a way to append something to tests/fp/meson.build:libtestfloat.c_args? Right now it is apparently set to tfcflags+fpcflags+CFLAGS.
> 
> 
> Olaf


