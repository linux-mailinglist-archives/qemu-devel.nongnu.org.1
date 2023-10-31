Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E14E7DCFA5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:51:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq51-0003Gi-5G; Tue, 31 Oct 2023 10:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxq4y-0003GE-Vi
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:50:52 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxq4x-0003Qb-BX
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:50:52 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5849fc56c62so3502095eaf.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763849; x=1699368649; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3iZKrU7Oej7wmXltUZOVesZb5zGcjOYJH7wiQDorDU=;
 b=DfyqYjibOPsNAIKh+5AteLQJSFgkeDdXBU45LqfzC/Q/F9c7Ry63Lpk7Ts/HUz1rxW
 eiqdZhPFp7mirvwWhafsVj7Ct9aAS7+4GW25kBqld3fwXKDdYMV9sCy8CNuEbyuM2/Y1
 Agkca6ytjj21EckM0ecJG0Ir5vtWbApGuUc/Fqz4shNTJi0stK/QVCLUCdVhBpI39Ivj
 h3HFwAvy438ihgHP92+1V7wXCbxVWI8PR6faAM0ouRoFZ2yU8BbSycVbyEYFCAAfKijj
 suBu6iav63WxlZTUny73kFmtb8rjICPq0yWFcvHB+I9UHhkYpfRPVBzyVbwtEPgbMIso
 7DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763849; x=1699368649;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t3iZKrU7Oej7wmXltUZOVesZb5zGcjOYJH7wiQDorDU=;
 b=DTN5nlOICZp0G6aK41zKGDc9AQVRXlXSDnlv4ZMiTHz/vtknkPZafZAa8r6mWjXAj5
 6oZa0Lov9v27eQJdfMfTI9tH3AwME1605z47AgEbsZmRYNXqtEYjmBssdIOI+e5UxVlp
 0w3ARCoai1XFdpic8cmEILZWJZHIaoEmpQWUrG5C+6WQmiRo+6olPu+8TCZ+87WvNmPk
 gV5ThoEiy5oOMaDg8Ce4fy9SKQFh99WDhownOZAXNKL3V2AAlO+lHFmSlryC3qNBZw7q
 FfGAuPNpchxODHR2oFZJ951Usc4J9PLk3bvQ9pX+uhtLZx4KPY1OSkLCTw3/ADkpLhAz
 JAQg==
X-Gm-Message-State: AOJu0YzMbkWGmisX6+1OpXj9hDDzrgWBawH8PMee+ZX1t5K256Df5Dez
 GCC3hYCYwqngeInnn5row7mpEA==
X-Google-Smtp-Source: AGHT+IE9QLiyyWc9l97XM/7DhGBU9uvIvmshDw+jkIsNqpsZR8h5Zuk0MMLKPibogOHeebQugVjXMg==
X-Received: by 2002:a05:6358:52c5:b0:168:ec27:47a1 with SMTP id
 z5-20020a05635852c500b00168ec2747a1mr17625202rwz.26.1698763849279; 
 Tue, 31 Oct 2023 07:50:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a633817000000b005b1bf3a200fsm1152261pga.1.2023.10.31.07.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:50:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------A0vvdnXNkH1Fre90xckkCxaN"
Message-ID: <0d60c6d4-a785-4abd-a16a-279b50abf09d@linaro.org>
Date: Tue, 31 Oct 2023 07:50:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] target/loongarch: Add set_vec_extctx to set
 LSX/LASX instructions extctx_flags
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, laurent@vivier.e, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, laurent@vivier.eu
References: <20231010033701.385725-1-gaosong@loongson.cn>
 <20231010033701.385725-3-gaosong@loongson.cn>
 <1c4c0856-337e-4c5e-b2af-6caf35060b0a@linaro.org>
 <24981f5e-3397-427e-a552-635887d581cd@loongson.cn>
 <c43b9404-fd99-4f8a-9e35-62f5a4e50b5b@linaro.org>
 <4f952bcc-61c9-b3b6-d858-00c64167c292@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <4f952bcc-61c9-b3b6-d858-00c64167c292@loongson.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------A0vvdnXNkH1Fre90xckkCxaN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/23 23:16, gaosong wrote:
>> Anyway, I think my previous suggestion is better:
>>
> Oh,  Could you  show more details?  I think I didn't get you point.
> 
>>>> If you want to track what the program is using, you should do it exactly like the real 
>>>> kernel: disable the execution unit, have the program trap, and the enable the 
>>>> execution unit when the trap occurs. At this point, CSR_EUEN enable bits contain 

Untested, but something like this.


r~


--------------A0vvdnXNkH1Fre90xckkCxaN
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-linux-user-loongarch64-Use-traps-to-track-LSX-LASX-u.patch"
Content-Disposition: attachment;
 filename*0="0001-linux-user-loongarch64-Use-traps-to-track-LSX-LASX-u.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyYTViNTVhMzNiYzYxMzNjZDMxODg1NmI5NWI4NDQxNjI3NzliZWFmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5k
ZXJzb25AbGluYXJvLm9yZz4KRGF0ZTogVHVlLCAzMSBPY3QgMjAyMyAwNzo0Njo1NCAtMDcw
MApTdWJqZWN0OiBbUEFUQ0hdIGxpbnV4LXVzZXIvbG9vbmdhcmNoNjQ6IFVzZSB0cmFwcyB0
byB0cmFjayBMU1gvTEFTWCB1c2FnZQoKU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+Ci0tLQogbGludXgtdXNlci9sb29u
Z2FyY2g2NC9jcHVfbG9vcC5jICAgICAgICAgICB8IDEzICsrKysrKysrKysrKysKIHRhcmdl
dC9sb29uZ2FyY2gvaW5zbl90cmFucy90cmFuc192ZWMuYy5pbmMgfCAxMSAtLS0tLS0tLS0t
LQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9saW51eC11c2VyL2xvb25nYXJjaDY0L2NwdV9sb29wLmMgYi9saW51
eC11c2VyL2xvb25nYXJjaDY0L2NwdV9sb29wLmMKaW5kZXggODk0ZmRkMTExYS4uNzNkN2I2
Nzk2YSAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9sb29uZ2FyY2g2NC9jcHVfbG9vcC5jCisr
KyBiL2xpbnV4LXVzZXIvbG9vbmdhcmNoNjQvY3B1X2xvb3AuYwpAQCAtNzIsNiArNzIsMTkg
QEAgdm9pZCBjcHVfbG9vcChDUFVMb29uZ0FyY2hTdGF0ZSAqZW52KQogICAgICAgICBjYXNl
IEVYQ0NPREVfQkNFOgogICAgICAgICAgICAgZm9yY2Vfc2lnX2ZhdWx0KFRBUkdFVF9TSUdT
WVMsIFRBUkdFVF9TSV9LRVJORUwsIGVudi0+cGMpOwogICAgICAgICAgICAgYnJlYWs7CisK
KyAgICAgICAgLyoKKyAgICAgICAgICogQmVnaW4gd2l0aCBMU1ggYW5kIExBU1ggZGlzYWJs
ZWQsIHRoZW4gZW5hYmxlIG9uIHRoZSBmaXJzdCB0cmFwLgorICAgICAgICAgKiBJbiB0aGlz
IHdheSB3ZSBjYW4gdGVsbCBpZiB0aGUgdW5pdCBpcyBpbiB1c2UuICBUaGlzIGlzIHVzZWQg
dG8KKyAgICAgICAgICogY2hvb3NlIHRoZSBsYXlvdXQgb2YgYW55IHNpZ25hbCBmcmFtZS4K
KyAgICAgICAgICovCisgICAgICAgIGNhc2UgRVhDQ09ERV9TWEQ6CisgICAgICAgICAgICBl
bnYtPkNTUl9FVUVOIHw9IFJfQ1NSX0VVRU5fU1hFX01BU0s7CisgICAgICAgICAgICBicmVh
azsKKyAgICAgICAgY2FzZSBFWENDT0RFX0FTWEQ6CisgICAgICAgICAgICBlbnYtPkNTUl9F
VUVOIHw9IFJfQ1NSX0VVRU5fQVNYRV9NQVNLOworICAgICAgICAgICAgYnJlYWs7CisKICAg
ICAgICAgY2FzZSBFWENQX0FUT01JQzoKICAgICAgICAgICAgIGNwdV9leGVjX3N0ZXBfYXRv
bWljKGNzKTsKICAgICAgICAgICAgIGJyZWFrOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2xvb25n
YXJjaC9pbnNuX3RyYW5zL3RyYW5zX3ZlYy5jLmluYyBiL3RhcmdldC9sb29uZ2FyY2gvaW5z
bl90cmFucy90cmFuc192ZWMuYy5pbmMKaW5kZXggOThmODU2YmIyOS4uOTJiMWQyMmUyOCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2xvb25nYXJjaC9pbnNuX3RyYW5zL3RyYW5zX3ZlYy5jLmlu
YworKysgYi90YXJnZXQvbG9vbmdhcmNoL2luc25fdHJhbnMvdHJhbnNfdmVjLmMuaW5jCkBA
IC00LDggKzQsNiBAQAogICogQ29weXJpZ2h0IChjKSAyMDIyLTIwMjMgTG9vbmdzb24gVGVj
aG5vbG9neSBDb3Jwb3JhdGlvbiBMaW1pdGVkCiAgKi8KIAotI2lmbmRlZiBDT05GSUdfVVNF
Ul9PTkxZCi0KIHN0YXRpYyBib29sIGNoZWNrX3ZlYyhEaXNhc0NvbnRleHQgKmN0eCwgdWlu
dDMyX3Qgb3Byc3opCiB7CiAgICAgaWYgKChvcHJzeiA9PSAxNikgJiYgKChjdHgtPmJhc2Uu
dGItPmZsYWdzICYgSFdfRkxBR1NfRVVFTl9TWEUpID09IDApKSB7CkBAIC0yMSwxNSArMTks
NiBAQCBzdGF0aWMgYm9vbCBjaGVja192ZWMoRGlzYXNDb250ZXh0ICpjdHgsIHVpbnQzMl90
IG9wcnN6KQogICAgIHJldHVybiB0cnVlOwogfQogCi0jZWxzZQotCi1zdGF0aWMgYm9vbCBj
aGVja192ZWMoRGlzYXNDb250ZXh0ICpjdHgsIHVpbnQzMl90IG9wcnN6KQotewotICAgIHJl
dHVybiB0cnVlOwotfQotCi0jZW5kaWYKLQogc3RhdGljIGJvb2wgZ2VuX3Z2dnZfcHRyX3Zs
KERpc2FzQ29udGV4dCAqY3R4LCBhcmdfdnZ2diAqYSwgdWludDMyX3Qgb3Byc3osCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ2VuX2hlbHBlcl9ndmVjXzRfcHRyICpmbikKIHsK
LS0gCjIuMzQuMQoK

--------------A0vvdnXNkH1Fre90xckkCxaN--

