Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40792712821
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YJ9-0005qw-OT; Fri, 26 May 2023 10:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ5-0005pC-H8
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1q2YJ2-0007CF-Cl
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:20:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QDFFUP027251; Fri, 26 May 2023 14:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cWSwFlqLIKJz+qVxgzazji48fjJK5uowMtC0HsNZB3Y=;
 b=VsPxMQNBJa2lrwKps75Jfvu7vMG+DtT7n6ThhT51FU4chz/KJhnMFcTwsywW39j+rKGC
 1F7nP8tSB2/0OoikHAly648hfmbvp9LCFGNkdKtygZDM4rGnMO51gwB8nBsYHuW5isbG
 k53cbw6K+Dk+oTomojHnRs48+Y4+eY7zr95xP1A+Z8gn5GaVP88V+K7T7kkh2z6fO22o
 S1cfmrf/dLk2IBJxcBFmmnjZRvKGGwOI2OVKSW3XyEtp1TiTvyVFc46spr6i4kv2PpUM
 hxGsi/njYMpYecgv/Y8EXI5oE3ZBN0SGyTHluepSA92D5Na2HI7fTAEZ3k7L3Tiw3059 FQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtpsp90pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:31 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34QEDS4u005625; 
 Fri, 26 May 2023 14:20:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qtvwq8dmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QEKUE8014047;
 Fri, 26 May 2023 14:20:30 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-tsimpson-lv.qualcomm.com
 [10.47.204.221])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34QEKTIQ014044
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 14:20:30 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 47164)
 id A715D6CA; Fri, 26 May 2023 07:20:29 -0700 (PDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, bcain@quicinc.com, quic_mathbern@quicinc.com,
 stefanha@redhat.com, ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 ltaylorsimpson@gmail.com
Subject: [PULL 2/5] Hexagon (target/hexagon) Fix assignment to tmp registers
Date: Fri, 26 May 2023 07:20:25 -0700
Message-Id: <20230526142028.1277954-3-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526142028.1277954-1-tsimpson@quicinc.com>
References: <20230526142028.1277954-1-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: eyuXwaynkPYWMP5M2-2JFUiNxtzI1mVX
X-Proofpoint-GUID: eyuXwaynkPYWMP5M2-2JFUiNxtzI1mVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_05,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=876
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260120
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=tsimpson@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

RnJvbTogTWFyY28gTGllYmVsIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+CgpUaGUgb3JkZXIg
aW4gd2hpY2ggaW5zdHJ1Y3Rpb25zIGFyZSBnZW5lcmF0ZWQgYnkgZ2VuX2luc24oKSBpbmZsdWVu
Y2VzCmFzc2lnbm1lbnQgdG8gdG1wIHJlZ2lzdGVycy4gRHVyaW5nIGdlbmVyYXRpb24sIHRtcCBp
bnN0cnVjdGlvbnMgKGUuZy4KZ2VuZXJhdGVfVjZfdmFzc2lnbl90bXApIHVzZSB2cmVnX3NyY19v
ZmYoKSB0byBkZXRlcm1pbmUgd2hhdCBraW5kIG9mCnJlZ2lzdGVyIHRvIHVzZSBhcyBzb3VyY2Uu
IElmIHNvbWUgaW5zdHJ1Y3Rpb24gKGUuZy4KZ2VuZXJhdGVfVjZfdm1weW93aF82NF9hY2MpIHVz
ZXMgYSB0bXAgcmVnaXN0ZXIgYnV0IGlzIGdlbmVyYXRlZCBwcmlvcgp0byB0aGUgY29ycmVzcG9u
ZGluZyB0bXAgaW5zdHJ1Y3Rpb24sIHRoZSB2cmVnc191cGRhdGVkX3RtcCBiaXQgbWFwCmlzbid0
IHVwZGF0ZWQgaW4gdGltZS4KCkV4bXBsZToKICAgIHsgdjE0LnRtcCA9IHYxNjsgdjI1ID0gdjE0
IH0gVGhpcyB3b3JrcyBwcm9wZXJseSBiZWNhdXNlCiAgICBnZW5lcmF0ZV9WNl92YXNzaWduX3Rt
cCBpcyBnZW5lcmF0ZWQgYmVmb3JlIGdlbmVyYXRlX1Y2X3Zhc3NpZ24KICAgIGFuZCB0aGUgYml0
IG1hcCBpcyB1cGRhdGVkLgoKICAgIHsgdjE1OjE0LnRtcCA9IHZjb21iaW5lKHYyMSwgdjE2KTsg
djI1OjI0ICs9IHZtcHlvKHYxOC53LHYxNC5oKSB9CiAgICBUaGlzIGRvZXMgbm90IHdvcmsgcHJv
cGVybHkgYmVjYXVzZSB2bXB5byBpcyBnZW5lcmF0ZWQgYmVmb3JlCiAgICB2Y29tYmluZSBhbmQg
dGhlcmVmb3JlIHRoZSBiaXQgbWFwIGRvZXMgbm90IHlldCBrbm93IHRoYXQgdGhlcmUncwogICAg
YSB0bXAgcmVnaXN0ZXIuCgpUaGUgcGFyZW50aGVzZXMgaW4gdGhlIGRlY29kaW5nIGZ1bmN0aW9u
IHdlcmUgaW4gdGhlIHdyb25nIHBsYWNlLgpNb3ZpbmcgdGhlbSB0byB0aGUgY29ycmVjdCBsb2Nh
dGlvbiBtYWtlcyBzaHVmZmxpbmcgb2YgLnRtcCB2ZWN0b3IKcmVnaXN0ZXJzIHdvcmsgYXMgZXhw
ZWN0ZWQuCgpTaWduZWQtb2ZmLWJ5OiBNYXJjbyBMaWViZWwgPHF1aWNfbWxpZWJlbEBxdWljaW5j
LmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4K
VGVzdGVkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+ClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6
IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgpNZXNzYWdlLUlkOiA8MjAyMzA1MjIxNzQ3
MDguNDY0MTk3LTEtcXVpY19tbGllYmVsQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29u
L21tdmVjL2RlY29kZV9leHRfbW12ZWMuYyB8ICA4ICsrKy0tLS0KIHRlc3RzL3RjZy9oZXhhZ29u
L2h2eF9taXNjLmMgICAgICAgICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysKIDIg
ZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMgYi90YXJnZXQvaGV4
YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMKaW5kZXggMDYxYTY1YWI4OC4uMTc0ZWIzYjc4
YiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jCisr
KyBiL3RhcmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYwpAQCAtMSw1ICsxLDUg
QEAKIC8qCi0gKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMSBRdWFsY29tbSBJbm5vdmF0aW9uIENl
bnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICogIENvcHlyaWdodChjKSAyMDE5LTIw
MjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4K
ICAqCiAgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKICAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQpAQCAtMTQ4LDkgKzE0OCw5IEBA
IGRlY29kZV9zaHVmZmxlX2Zvcl9leGVjdXRpb25fdm9wcyhQYWNrZXQgKnBrdCkKICAgICBpbnQg
aTsKICAgICBmb3IgKGkgPSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgewogICAgICAgICB1
aW50MTZfdCBvcGNvZGUgPSBwa3QtPmluc25baV0ub3Bjb2RlOwotICAgICAgICBpZiAoR0VUX0FU
VFJJQihvcGNvZGUsIEFfTE9BRCkgJiYKLSAgICAgICAgICAgIChHRVRfQVRUUklCKG9wY29kZSwg
QV9DVklfTkVXKSB8fAotICAgICAgICAgICAgIEdFVF9BVFRSSUIob3Bjb2RlLCBBX0NWSV9UTVAp
KSkgeworICAgICAgICBpZiAoKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0xPQUQpICYmCisgICAgICAg
ICAgICAgR0VUX0FUVFJJQihvcGNvZGUsIEFfQ1ZJX05FVykpIHx8CisgICAgICAgICAgICBHRVRf
QVRUUklCKG9wY29kZSwgQV9DVklfVE1QKSkgewogICAgICAgICAgICAgLyoKICAgICAgICAgICAg
ICAqIEZpbmQgcHJpb3IgY29uc3VtaW5nIHZlY3RvciBpbnN0cnVjdGlvbnMKICAgICAgICAgICAg
ICAqIE1vdmUgdG8gZW5kIG9mIHBhY2tldApkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24v
aHZ4X21pc2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggMDlkZWM4ZDdh
MS4uYjQ1MTcwYWNkMSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYwor
KysgYi90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCkBAIC02MCw2ICs2MCwzNiBAQCBzdGF0
aWMgdm9pZCB0ZXN0X2xvYWRfdG1wKHZvaWQpCiAgICAgY2hlY2tfb3V0cHV0X3coX19MSU5FX18s
IEJVRlNJWkUpOwogfQogCitzdGF0aWMgdm9pZCB0ZXN0X2xvYWRfdG1wMih2b2lkKQoreworICAg
IHZvaWQgKnBvdXQwID0gJm91dHB1dFswXTsKKyAgICB2b2lkICpwb3V0MSA9ICZvdXRwdXRbMV07
CisKKyAgICBhc20gdm9sYXRpbGUoCisgICAgICAgICJyMCA9ICMweDAzMDMwMzAzXG5cdCIKKyAg
ICAgICAgInYxNiA9IHZzcGxhdChyMClcblx0IgorICAgICAgICAicjAgPSAjMHgwNDA0MDQwNFxu
XHQiCisgICAgICAgICJ2MTggPSB2c3BsYXQocjApXG5cdCIKKyAgICAgICAgInIwID0gIzB4MDUw
NTA1MDVcblx0IgorICAgICAgICAidjIxID0gdnNwbGF0KHIwKVxuXHQiCisgICAgICAgICJ7XG5c
dCIKKyAgICAgICAgIiAgIHYyNToyNCArPSB2bXB5byh2MTgudywgdjE0LmgpXG5cdCIKKyAgICAg
ICAgIiAgIHYxNToxNC50bXAgPSB2Y29tYmluZSh2MjEsIHYxNilcblx0IgorICAgICAgICAifVxu
XHQiCisgICAgICAgICJ2bWVtKCUwICsgIzApID0gdjI0XG5cdCIKKyAgICAgICAgInZtZW0oJTEg
KyAjMCkgPSB2MjVcblx0IgorICAgICAgICA6IDogInIiKHBvdXQwKSwgInIiKHBvdXQxKQorICAg
ICAgICA6ICJyMCIsICJ2MTYiLCAidjE4IiwgInYyMSIsICJ2MjQiLCAidjI1IiwgIm1lbW9yeSIK
KyAgICApOworCisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVfQllURVMgLyA0
OyArK2kpIHsKKyAgICAgICAgZXhwZWN0WzBdLndbaV0gPSAweDE4MGMwMDAwOworICAgICAgICBl
eHBlY3RbMV0ud1tpXSA9IDB4MDAwYzE4MTg7CisgICAgfQorCisgICAgY2hlY2tfb3V0cHV0X3co
X19MSU5FX18sIDIpOworfQorCiBzdGF0aWMgdm9pZCB0ZXN0X2xvYWRfY3VyKHZvaWQpCiB7CiAg
ICAgdm9pZCAqcDAgPSBidWZmZXIwOwpAQCAtNDM1LDYgKzQ2NSw3IEBAIGludCBtYWluKCkKICAg
ICBpbml0X2J1ZmZlcnMoKTsKIAogICAgIHRlc3RfbG9hZF90bXAoKTsKKyAgICB0ZXN0X2xvYWRf
dG1wMigpOwogICAgIHRlc3RfbG9hZF9jdXIoKTsKICAgICB0ZXN0X2xvYWRfYWxpZ25lZCgpOwog
ICAgIHRlc3RfbG9hZF91bmFsaWduZWQoKTsKLS0gCjIuMjUuMQoK

